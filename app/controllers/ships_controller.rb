
class ShipsController < ApplicationController

  before_action :set_ship, only: %i[ show update destroy ]

# GET /ships
  def index
    @ships = Ship.all

    render json: @ships
  end

  # GET /ships/1
  def show
    render json: {ship: @ship}, status: :ok
  end

  # POST /ships
  def create
    render json: {message: "fuel level can not exceed fuel capacity"}, status: :unprocessable_entity if (ship_params[:fuel_level] > ship_params[:fuel_capacity])
    @ship = Ship.new(ship_params)
    @ship.pilot = Pilot.find(ship_params[:pilot_id])

    if @ship.save
      render json: {data: @ship, message: "ship successfully created"}, status: :ok
    else
      render json: {message: @ship.errors}, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /ships/1
  def update
    if @ship.update(ship_params)
      render json: {data: @ship, message: "ship successfully updated"}, status: :ok
    else
      render json: { message: @ship.errors}, status: :unprocessable_entity
    end
  end

  # DELETE /ships/1
  def destroy
    if @ship.destroy
        render json: {message: "ship successfully deleted"}, status: :ok
    else
      render json: {message: @ship.errors}, status: :unprocessable_entity
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_ship
    @ship = Ship.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def ship_params
    params.require(:ship).permit(:weight_capacity, :fuel_capacity, :fuel_level, :pilot_id)
  end
end
