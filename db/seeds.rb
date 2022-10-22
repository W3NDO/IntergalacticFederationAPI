# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: "Star Wars" }, { name: "Lord of the Rings" }])
#   Character.create(name: "Luke", movie: movies.first)

# resource seeds
resource_types = ["minerals", "water", "food"]
valid_routes = {"andvari" => {
    "aqua" => 13,
    "calas" => 23,
    "demeter" => -1 # if amount of fuel is -1, then travel is blocked
},
"demeter" => {
    "aqua" => 22,
    "calas" => 25,
    "andvari" => -1
},
"aqua" => {
    "demeter" => 30,
    "calas" => 12,
    "andvari" => -1
},
"calas" => {
    "andvari" => 20,
    "demeter" => 25,
    "aqua" => 15
}}

# Planet seeds
planets = ["andvari", "aqua", "calas", "demeter"]
planets.each do |planet|
    Planet.create(name: planet, resources_received: 0, resources_sent: 0)
end

# pilot seeds
pilot_names = ["Jean Luc Piccard", "Jane Shephard", "Jack Sparrow"]
valid_certifications = [199992, 199984, 199836 ]
pilot_names.each_with_index do |pilot, index|
    Pilot.create(
        name: pilot,
        age: rand(18..35),
        location_planet: planets.sample,
        credits_cents: rand(100..1000),
        certification: valid_certifications[index]
    )
end

#ship seeds
ship_names = ["USS Orville", "Normandy", "Black Perl"]
ship_names.each_with_index do |ship, index|
    Ship.create(
        name: ship, 
        pilot_id: index+1,
        fuel_capacity: rand(600..1000),
        weight_capacity: rand(100000..200000),
        fuel_level: rand(0..900)
    )
end

# contract seeds
4.times do
    origin = valid_routes.keys.sample
    destination = valid_routes[origin].keys.sample
    resource = resource_types.sample
    Contract.create(
        description: "#{pilot_names.sample} transported #{resource} from #{origin} to #{destination} ",
        payload: resource,
        origin_planet: origin,
        destination_planet: destination,
        value_cents: rand(200..500),
        status: ["open", "closed"].sample
    )
end

#resource seeds
resource_types.each do |resource|
    Resource.create(
        name: resource,
        weight: rand(100..300)
    )
end

# FinancialTransaction seeds



