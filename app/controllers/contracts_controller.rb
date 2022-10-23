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
    @contract = Contract.new(contract_params)

    if @contract.save
      render json: {data: @contract, message: "Contract was successfully created"}, status: :ok
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


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_contract
      @contract = Contract.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def contract_params
      params.require(:contract).permit(:description, :payload, :origin_planet, :destination_planet, :value, :status)
    end
end
