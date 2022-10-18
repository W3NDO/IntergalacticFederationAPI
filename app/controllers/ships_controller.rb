class ShipsController < ApplicationController
      # GET /ships
  def index
    @ships = ship.all

    render json: @ships
  end

  # GET /ships/1
  def show
    render json: @ship
  end

  # POST /ships
  def create
    @ship = ship.new(ship_params)

    if @ship.save
      render json: {data: @ship, status: "SUCCESS", message: "ship successfully created"}, status: :ok
    else
      render json: {status: "FAILURE", message: @ship.errors, status: :unprocessable_entity}
    end
  end

  # PATCH/PUT /ships/1
  def update
    if @ship.update(ship_params)
      render json: {data: @ship, status: "SUCCESS", message: "ship successfully updated"}, status: :ok
    else
      render json: {status: "FAILURE", message: @ship.errors, status: :unprocessable_entity}
    end
  end

  # DELETE /ships/1
  def destroy
    if @ship.destroy
        render json: {status: "SUCCESS", message: "ship successfully deleted"}, status: :ok
    else
      render json: {status: "FAILURE", message: @ship.errors, status: :unprocessable_entity}
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_ship
      @ship = ship.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def ship_params
      params.require(:ship).permit(:weight_capacity, :fuel_capacity, :fuel_level, :pilot_id)
    end
end
