class TravelController < ApplicationController

    def create
        render json: {error: "Ship is required"}, status: :unprocessable_entity and return unless travel_params[:ship_id]
        render json: {error: "Origin Planet is required"}, status: :unprocessable_entity and return  unless travel_params[:origin_planet_id]
        render json: {error: "Destination Planet is required"}, status: :unprocessable_entity and return unless travel_params[:destination_planet_id]
        render json: {error: "Origin Planet can not be the same as destination planet"}, status: :unprocessable_entity and return unless travel_params[:origin_planet_id] != travel_params[:destination_planet_id]

        ship = Ship.find(travel_params[:ship_id]) rescue nil
        origin_planet = Planet.find(travel_params[:origin_planet_id]) rescue nil
        destination_planet = Planet.find(travel_params[:destination_planet_id]) rescue nil
        
        if ship==nil
            render json: {error: "Ship does not exist"}, status: :unprocessable_entity and return
        elsif origin_planet == nil
            render json: {error: "Origin Planet does not exist"}, status: :unprocessable_entity and return
        elsif destination_planet == nil
            render json: {error: "Destination Planet does not exist"}, status: :unprocessable_entity and return
        end

        pilot = ship.pilot
        current_location = Planet.find_by(name: pilot.location_planet)
        if current_location.id == origin_planet.id
            if Planet.travellable?(origin_planet.name, destination_planet.name, ship.fuel_level)
                new_fuel_level = ship.fuel_level - Planet::TRAVEL_ADJACENCY_LIST[origin_planet.name][destination_planet.name]
                if new_fuel_level < 1 
                    render json: {error: "Unable to travel to #{destination_planet.name} due to low fuel"}, status: :unprocessable_entity and return
                else
                    ship.update(fuel_level: new_fuel_level)
                    pilot.update(location_planet: destination_planet.name)
                    render json: {message: "Successfully flew from #{origin_planet.name} to #{destination_planet.name} aboard the #{ship.name}"}, status: :ok and return
                end
            end
            render json: {error: "Travel between #{origin_planet.name} and #{destination_planet.name} is not possible"}, status: :unprocessable_entity and return
        else
            if Planet.travellable?(current_location.name, origin_planet.name, ship.fuel_level)
                temp_fuel_level = ship.fuel_level - Planet::TRAVEL_ADJACENCY_LIST[current_location.name][origin_planet.name]
                if temp_fuel_level < 1
                    render json: {error: "Unable to travel to #{destination_planet.name} due to low fuel"}, status: :unprocessable_entity and return
                else
                    if Planet.travellable?(origin_planet.name, destination_planet.name, temp_fuel_level)
                        new_fuel_level = temp_fuel_level - Planet::TRAVEL_ADJACENCY_LIST[origin_planet.name][destination_planet.name]
                        ship.update(fuel_level: new_fuel_level)
                        pilot.update(location_planet: destination_planet.name)
                        render json: {message: "Started trip from #{current_location.name} and flew to #{origin_planet.name} and successfully flew from there to #{destination_planet.name} aboard the #{ship.name}"}, status: :ok and return
                    else
                        if Planet::TRAVEL_ADJACENCY_LIST[origin_planet.name].keys.include?(destination_planet.name)
                            render json: {error: "Unable to travel from #{origin_planet.name} to #{destination_planet.name} due to low fuel"}, status: :unprocessable_entity and return
                        else
                            render json: {error: "Unable to travel from #{origin_planet.name} to #{destination_planet.name} due an issue with the route"}, status: :unprocessable_entity and return
                        end
                        
                    end
                end
            else
                if Planet::TRAVEL_ADJACENCY_LIST[current_location.name].keys.include?(destination_planet.name)
                    render json: {error: "Unable to travel from #{origin_planet.name} to #{destination_planet.name} due to low fuel"}, status: :unprocessable_entity and return
                else
                    render json: {error: ">>Unable to travel from #{origin_planet.name} to #{destination_planet.name} due an issue with the route"}, status: :unprocessable_entity and return
                end
                render json: {error: "#{Planet::TRAVEL_ADJACENCY_LIST[current_location.name].keys.include?(destination_planet.name)}  Unable to travel from the ship's current loacation at #{current_location.name} to #{origin_planet.name} due an issue with the route"}, status: :unprocessable_entity and return
            end
        end



    end

    private
    def travel_params
        params.require(:travel).permit(:ship_id, :origin_planet_id, :destination_planet_id)
    end
end