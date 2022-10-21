require 'rails_helper'

RSpec.describe Planet, type: :model do
  describe "Ability to travel between planets" do
    it "retrieves the planets that can be travelled to from Andvari" do
      expect(Planet::TRAVEL_ADJACENCY_LIST["andvari"]).to eq({
        "aqua" => 13,
        "calas" => 23,
        "demeter" => -1
      })
    end

    it "returns true if one can travel between Aqua and Demeter with more than 30 units of fuel" do
      expect(Planet.travellable?("Aqua", "Demeter", 40 )).to be true
    end

    it "returns false if one can travel between Aqua and Demeter with less than 30 units of fuel" do
      expect(Planet.travellable?("Aqua", "Demeter", 29 )).to be false
    end

    it "returns false if one tries to travel between Aqua and Andvari" do
      expect(Planet.travellable?("Aqua", "Andvari", 40 )).to be false
    end
  end
end
