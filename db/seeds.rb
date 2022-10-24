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


# pilot seeds
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

# ship seeds
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

# transport transaction seeds
3.times do |t|
    origin = valid_routes.keys.sample
    destination = valid_routes[origin].keys.sample
    pilot = Pilot.find(t+1)
    
    FinancialTransaction.create(
        description: "Transporting #{resource_types[t]} from #{origin} to #{destination}",
        transaction_type: "resource_transport",
        amount: rand(100..500),
        pilot_id: rand(1..3),
        destination_planet_id: Planet.find_by(name: destination).id,
        origin_planet_id: Planet.find_by(name: origin).id,
        ship_id: Ship.find_by(pilot_id: pilot.id).id,
        value_cents: rand(300..400)
    )    
end

# a fuel refill transaction
4.times do
    origin = valid_routes.keys.sample
    pilot = Pilot.find(rand(1..3))
    FinancialTransaction.create(
        description: "Refuelling at #{origin}",
        transaction_type: "fuel_refill",
        amount: rand(100..500),
        pilot_id: rand(1..3),
        origin_planet_id: Planet.find_by(name: origin).id,
        ship_id: Ship.find_by(pilot_id: pilot.id).id,
        value_cents: rand(400..700)
    )
end

# Contract seeds
3.times do |t|
    origin = valid_routes.keys.sample
    destination = valid_routes[origin].keys.sample
    resource = resource_types.sample
    tx = FinancialTransaction.find(t+1)
    Contract.create(
        description: "Transport #{resource_types[t]} from #{origin} to #{destination}",
        payload: resource,
        origin_planet: origin,
        destination_planet: destination,
        value_cents: tx.value_cents,
        status: ["open", "closed"].sample,
        financial_transaction_id: (t+1)
    )
end

# resource seeds
resource_types.each_with_index do |resource, index|
    Resource.create(
        name: resource,
        weight: rand(100..300),
        contract_id: index+1
    )
end
