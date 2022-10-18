require 'rails_helper'

RSpec.describe Ship, type: :model do
  let(:ship) { Ship.create(weight_capacity: 100, fuel_cpacity: 120, fuel_level: 80 ) }
  let(:pilot) { Ship.create(certification: 149997, name: "Kirk", age: 24, location_planet: "Calas") }

  xit "Ensures that the Ship validations pass." do
    expect(ship.valid?).to be true
  end

  xit "Ensures that we can create a valid association between a ship and a pilot." do
    ship.pilots_id = pilot.id
    expect(ship.pilot.id).to eq pilot.id
  end


end
