require 'rails_helper'

RSpec.describe Ship, type: :model do
  let(:ship) { Ship.create(weight_capacity: 100, fuel_capacity: 120, fuel_level: 80 ) }
  let(:pilot) { Pilot.create(certification: 149997, name: "Kirk", age: 24, location_planet: "Calas") }

  it "Ensures that the Ship validations pass." do
    expect(ship.valid?).to be false

    ship.pilot = pilot
    expect(ship.valid?).to be true
  end

  it "Ensures that we can create a valid association between a ship and a pilot." do
    ship.pilot = pilot
    expect(ship.pilot.id).to eq pilot.id
  end

end
