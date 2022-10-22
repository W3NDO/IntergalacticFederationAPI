class PlanetsController < ApplicationController
  before_action :set_planet, only: %i[ show update destroy ]

  # GET /planets
  def index
    @planets = Planet.all

    render json: @planets
  end

  # GET /planets/1
  def show
    render json: @planet
  end

  # POST /planets
  def create
    @planet = Planet.new(planet_params)

    if @planet.save
      render json: @planet, status: :created, location: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /planets/1
  def update
    # check_castable(planet_params[:resources_sent], planet_params[:resources_received])
    if @planet.update(planet_params)
      render json: @planet
    else
      render json: @planet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /planets/1
  def destroy
    @planet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_planet
      @planet = Planet.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def planet_params
      params.require(:planet).permit(:name, :resources_received, :resources_sent)
    end

    def check_castable(sent, received)
      sent_int = Integer(sent) rescue nil
      received_int = Integer(received) rescue nil
      if sent_int
        planet_params[:resources_sent] = sent_int
      else 
        raise ArgumentError "resources_sent must be an int"
      end
      if received_int
        planet_params[:resources_received] = received_int
      else
        raise ArgumentError "resources_received must be an int"
      end
    end
end
