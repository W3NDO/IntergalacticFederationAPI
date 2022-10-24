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

  describe "updating totals of the planet" do
    let(:new_sent){{"food"=>10, "water"=>50, "minerals"=>15}}
    let(:new_received){{"food"=>100, "water"=>30, "minerals"=>10}}
    let(:planet){ Planet.create!(
      name: "andvari", 
      resources_sent:{
        "food"=>0, "water"=>0, "minerals"=>0
      },
      resources_received: {
        "food"=>0, "water"=>0, "minerals"=>0
      }
      )}

      it "updates the planet resources tally" do
        expect(planet.update_totals(new_sent, new_received)).to be true
        planet.reload
        expect(planet.resources_sent).to eq({"food"=>10, "water"=>50, "minerals"=>15})
        expect(planet.update_totals(new_sent, {})).to be true
        expect(planet.update_totals({"chese" => 123}, new_received)).to be true
      end
  end
end
