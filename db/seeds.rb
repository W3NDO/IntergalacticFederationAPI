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
pp ">>>>> Seeding Planets"

planets = ["andvari", "aqua", "calas", "demeter"]
planets.each do |planet|
    Planet.create(
        name: planet, 
        resources_received: {
            "minerals": 0,
            "food": 0,
            "water": 0
        }, 
        resources_sent: {
            "minerals": 0,
            "food": 0,
            "water": 0
        }
    )
end

pp "#{Planet.count} planets created"

# pilot seeds
pp ">>>>> Seeding Pilots"

pilot_names = ["Jean Luc Piccard", "Jane Shephard", "Jack Sparrow"]
valid_certifications = [1999939, 1999948, 1999957, ]
pilot_names.each_with_index do |pilot, index|
    Pilot.create(
        name: pilot,
        age: rand(18..35),
        location_planet: planets.sample,
        credits_cents: rand(100..1000),
        certification: valid_certifications[index]
    )
end

pp "#{Pilot.count} pilots created"

#ship seeds
pp ">>>>> Seeding Ships"

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
pp "#{Ship.count} ships created"

# contract seeds
pp ">>>>> Seeding Contracts"
4.times do
    origin = valid_routes.keys.sample
    destination = valid_routes[origin].keys.sample
    resource = resource_types.sample
    Contract.create(
        description: "Transport #{resource} from #{origin} to #{destination}",
        payload: resource,
        origin_planet: origin,
        destination_planet: destination,
        value_cents: rand(200..500),
        status: ["open", "closed"].sample
    )
end
pp "#{Contract.count} contracts created"

#resource seeds
pp ">>>>> Seeding Resources"
resource_types.each do |resource|
    Resource.create(
        name: resource,
        weight: rand(100..300)
    )
end
pp "#{Resource.count} resources created"

# FinancialTransaction seeds
pp ">>>>> Seeding Financial Transactions"
# This is a transport transaction
pp " \t building Transport transactions"
2.times do
    origin = valid_routes.keys.sample
    destination = valid_routes[origin].keys.sample
    pilot = Pilot.find(rand(1..3))
    FinancialTransaction.create(
        description: "Transporting #{resource_types.sample} from #{origin} to #{destination}",
        transaction_type: "resource_transport",
        amount: rand(100..500),
        pilot_id: rand(1..3),
        destination_planet_id: Planet.find_by(name: destination).id,
        origin_planet_id: Planet.find_by(name: origin).id,
        ship_id: Ship.find_by(pilot_id: pilot.id).id  
    )    
end
pp "#{FinancialTransaction.count} Transport transactions created"
# a fuel refill transaction
pp " \t building Fuel Refill transactions"
2.times do
    origin = valid_routes.keys.sample
    pilot = Pilot.find(rand(1..3))
    FinancialTransaction.create(
        description: "Refuelling at #{origin}",
        transaction_type: "fuel_refill",
        amount: rand(100..500),
        pilot_id: rand(1..3),
        origin_planet_id: Planet.find_by(name: origin).id,
        ship_id: Ship.find_by(pilot_id: pilot.id).id 
    )
end
pp "#{FinancialTransaction.count} Fuel Refill transactions created"


