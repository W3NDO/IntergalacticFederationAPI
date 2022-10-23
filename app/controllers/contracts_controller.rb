class ContractsController < ApplicationController
  before_action :set_contract, only: %i[ show update destroy ]

  # GET /contracts
  def index
    status = nil
    if params[:status]
      @contracts = Contract.all.where(status: params[:status])
    else
      @contracts = Contract.all
    end

    render json: {data: @contracts}, status: :ok
  end

  # GET /contracts/1
  def show
    render json: {data: @contract}, status: :ok
  end

  # POST /contracts
  def create
    resource_fields = contract_params[:resources_attributes]
    @contract = Contract.new(contract_params.except(:resources_attributes))
    if @contract.save
      resource_fields[:contract_id] = @contract.id
      @resource = Resource.create(resource_fields)
      render json: {data: [@contract, @resource], message: "Contract was successfully created"}, status: :ok
    else
      render json: {data: @contract.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /contracts/1
  def update
    if @contract.update(contract_params)
      render json: {data: @contract, message: "Contract was successfully updated"}, status: :ok
    else
      render json: {data: @contract.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /contracts/1
  def destroy
    if @contract.destroy
      render json: {message: "Contract successfully deleted"}, status: :ok
    else
      render json: {message:"Failed to destroy contract"}, status: :unprocessable_entity
    end
  end

  def accept
    render json: {error: "A pilot is required"}, status: :unprocessable_entity and return unless accept_params[:pilot_id]
    render json: {error: "A contract is required"}, status: :unprocessable_entity and return unless accept_params[:contract_id] or params[:id]

    pilot = Pilot.find(accept_params[:pilot_id]) rescue nil
    contract = Contract.find(accept_params[:contract_id]) rescue nil
    unless contract
      contract = Contract.find(params[:id]) rescue nil
    end


    render json: {error: "Pilot does not exist"}, status: :not_found and return unless pilot
    render json: {error: "Contract does not exist"}, status: :not_found and return unless contract

    render json: {error: "Contract is already being executed"}, status: :unprocessable_entity and return if contract.active?
    render json: {error: "Contract can not be accepted as it is already closed"}, status: :unprocessable_entity and return if contract.closed?

    origin_planet = Planet.find_by(name: contract.origin_planet)
    destination_planet = Planet.find_by(name: contract.destination_planet)
    ship = pilot.ship

    contract_feasible = Planet.travellable_with_fuel?(contract.origin_planet, contract.destination_planet, ship.fuel_level)
    unless contract_feasible[0]
      case contract_feasible[1]
      when "route_block"
        render json: {error: "Unable to fulfil contract since travel from #{origin_planet.name} to #{destination_planet.name} is blocked"}, status: :unprocessable_entity and return
      when "fuel"
        render json: {error: "Unable to fulfil contract since the ship #{ship.name} does not have enough fuel"}
      end
    end

    # update planet sent
    # update the planet received
    # update pilot
    # update ship
    ship.update(fuel_level: ship.fuel_level - Planet::TRAVEL_ADJACENCY_LIST[origin_planet.name][destination_planet.name])
    pilot.update(location_planet: destination_planet.name)
    contract.active! # sets the contract status to active. 

    transaction = FinancialTransaction.new(
      description: "#{pilot.name} is transporting #{contract.payload} from #{contract.origin_planet} to #{contract.destination_planet}",
      transaction_type: "resource_transport",
      amount: contract.resources.pluck(:weight).sum,
      pilot_id: pilot.id,
      origin_planet_id: origin_planet.id,
      destination_planet_id: destination_planet.id,
      ship_id: ship.id,
      value_cents: contract.value_cents,
      transaction_origin_planet: origin_planet.name,
      transaction_destination_planet: destination_planet.name,
      pilot_certification: pilot.certification,
      ship_name: ship.name,
      transaction_hash: create_hash
    )
    if transaction.save
      render json: {message: "Contract accepted by #{pilot.name} of the #{ship.name}", transaction: transaction}, status: :ok and return
    else
      render json: {error: "unable to complete transaction due to a server error"}, status: :internal_server_error and return
    end
  end

  def fulfil_contract
    render json: {message: "Contract fulfiled, pilot has been credited"}
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id]) rescue nil
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.require(:contract).permit(:description, :payload, :origin_planet, :destination_planet, :value_cents, :status, resources_attributes: [:name, :weight])
    end

    def accept_params
      params.require(:contract).permit(:pilot_id, :contract_id)
    end
end
