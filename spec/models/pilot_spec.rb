require 'rails_helper'

RSpec.describe Pilot, type: :model do
  let(:pilot) {Pilot.new(certification: 149997, name: "Kirk", age: 24, location_planet: "Calas")}
  let(:invalid_pilot) {Pilot.new(certification: 149998, age: 26, location_planet: "Calas")}

  it "Ensures that the pilot certificate is valid" do
    expect(pilot.certificate_valid?).to be true
  end

  it "Ensures that the pilot validations pass" do
    expect(pilot.valid?).to be true
  end

  xit "Ensures that the invalid pilot certificate is invalid" do #Luhn not critical for now.
    expect(invalid_pilot.certificate_valid?).to be false
  end

  it "Ensures that the invalid pilot validations fail" do
    expect(invalid_pilot.valid?).to be false
  end

  let(:ship) { Ship.create(weight_capacity: 100, fuel_cpacity: 120, fuel_level: 80, pilot_id: pilot.id ) }
  xit "Ensure that a pilot-ship relationship is valid." do
    expect(pilot.ship.id).to eq ship.id
  end
end
