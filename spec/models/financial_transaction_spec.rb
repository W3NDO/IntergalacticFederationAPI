require 'rails_helper'

RSpec.describe FinancialTransaction, type: :model do
  let(:pilot){Pilot.create!(
    name: "Jean Luc Piccard",
    age: rand(18..35),
    location_planet: "calas",
    credits_cents: rand(100..1000),
    certification: 199513)
  }
  let(:ship){ Ship.create!(
    name: "Normandy", 
    pilot_id: pilot.id,
    fuel_capacity: rand(600..1000),
    weight_capacity: rand(100000..200000),
    fuel_level: rand(0..900)
  )}
  let(:planet_origin){
    Planet.create!(name: "calas", resources_received: 0, resources_sent: 0)
  }
  let(:planet_destination){
    Planet.create!(name: "andvari", resources_received: 0, resources_sent: 0)
  }
  let(:valid_transport_transaction) {FinancialTransaction.new(
    description: "Transporting minerals from #{planet_origin.name} to #{planet_destination.name}",
    transaction_type: "resource_transport",
    amount: rand(100..500),
    pilot_id: pilot.id,
    destination_planet_id: planet_destination.id,
    origin_planet_id: planet_origin.id,
    ship_id: ship.id )
  }
  let(:valid_refill_transaction) { FinancialTransaction.new(
    description: "Refuelling at Calas",
    transaction_type: "fuel_refill",
    amount: rand(100..500),
    pilot_id: pilot.id,
    origin_planet_id: planet_origin.id,
    ship_id: ship.id)
  }
  
  let(:invalid_transaction) { FinancialTransaction.new(
    description: "Refuelling at Calas",
    transaction_type: "fuel_refill",
    amount: rand(100..500),
    pilot_id: pilot.id,
    ship_id: ship.id)
  }
  
  it "creates a valid transport transaction" do
    expect(valid_transport_transaction.valid?).to be true
  end

  it "creates a valid fuel refill transaction" do
    expect(valid_refill_transaction.valid?).to be true
  end

  it "creates an invalid transaction" do
    expect(invalid_transaction.valid?).to be false
  end
end
