class FinancialTransactionsController < ApplicationController
  before_action :set_financial_transaction, only: %i[ show update destroy ]

  # GET /financial_transactions
  def index
    flag = nil
    if params[:type]
      render json: {error: "Wrong value for the type flag given"}, status: :not_acceptable and return unless ["fuel_refill", "resource_transport"].include?params[:type]
      @financial_transactions = FinancialTransaction.where(transaction_type: params[:type])
    else
      @financial_transactions = FinancialTransaction.all
    end

    render json: @financial_transactions
  end

  # GET /financial_transactions/1
  def show
    render json: @financial_transaction
  end

  # POST /financial_transactions
  def create
    @financial_transaction = FinancialTransaction.new(financial_transaction_params)
    if @financial_transaction.save
      render json: @financial_transaction, status: :created, location: @financial_transaction
    else
      render json: @financial_transaction.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /financial_transactions/1
  def update
    if @financial_transaction.update(financial_transaction_params)
      render json: @financial_transaction
    else
      render json: @financial_transaction.errors, status: :unprocessable_entity
    end
  end

  # DELETE /financial_transactions/1
  def destroy
    @financial_transaction.destroy
  end

  def fuel_refill
    fuel_unit_value = 7
    render json: {error: "Ship is required"}, status: :unprocessable_entity and return unless refill_params[:ship_id]
    render json: {error: "Planet is required"}, status: :unprocessable_entity and return  unless refill_params[:planet_id]
    render json: {error: "Number of units is required"}, status: :unprocessable_entity and return unless refill_params[:units_of_fuel]
    fuel_units = nil
    fuel_units = Float(refill_params[:units_of_fuel]) rescue nil
      
    unless fuel_units
      render json: {error: "Fuel Units is required to be an number"}, status: :unprocessable_entity and return
    end

    ship = Ship.find(refill_params[:ship_id]) rescue nil
    planet = Planet.find(refill_params[:planet_id]) rescue nil
    if ship == nil
      render json: {error: "Ship does not exist"}, status: :unprocessable_entity and return
    elsif planet == nil
        render json: {error: "Planet does not exist"}, status: :unprocessable_entity and return
    end

    pilot = Pilot.find(ship.pilot_id)
    credits_due = fuel_units * fuel_unit_value
    # check if the pilot can afford the fuel
    if pilot.credits_cents < credits_due
      render json: {error: "Ship's pilot can not afford to buy #{refill_params[:units_of_fuel]} units of fuel"}, status: :unprocessable_entity and return
    end

    transaction = FinancialTransaction.new(
      description: "The ship #{ship.name} refuelled at #{planet.name}",
      transaction_type: "fuel_refill",
      amount: fuel_units,
      pilot_id: pilot.id,
      origin_planet_id: planet.id,
      ship_id: ship.id,
      value_cents: credits_due,
      transaction_origin_planet: planet.name,
      pilot_certification: pilot.certification,
      ship_name: ship.name,
      transaction_hash: create_hash
    )
    if transaction.save
      ship.update(fuel_level: ship.fuel_level + fuel_units)
      pilot.update(credits_cents: pilot.credits_cents - credits_due)
    else
      render json: {error: "Unable to complete fuel refill transaction"}, status: :internal_server_error and return
    end

    render json: {data: transaction}, status: :ok and return
  end

  private

    def refill_params
      params.require(:refill).permit(:ship_id, :planet_id, :units_of_fuel)
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_financial_transaction
      @financial_transaction = FinancialTransaction.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def financial_transaction_params
      params.require(:financial_transaction).permit(:description, :type, :transaction_hash, :transaction_type, :value_cents, :amount, :origin_planet_id, :destination_planet_id, :ship_id, :pilot_id)
    end

    def create_hash() #v2
      # return if params.keys.include?(:transaction_hash)
      token = nil
      loop do
        token = SecureRandom.hex
        break unless FinancialTransaction.all.pluck(:transaction_hash).include?(token)
      end
      token
    end
end
