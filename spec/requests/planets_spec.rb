require 'rails_helper'

RSpec.describe "/planets", type: :request do
  let(:valid_headers) {
    {}
  }


  describe "GET /index" do
    it "renders a successful response" do
      get planets_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      Planet.create({
        name: "andvari",
        resources_sent: {"water": 10},
          resources_received: {"food": 10}
      })
      planet = Planet.first
      get planet_url(planet), as: :json
      expect(response).to be_successful
    end
  end

  describe "PATCH /update" do
    
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "andvari",
          resources_sent: {"water": 10},
          resources_received: {"food": 10}
        }
      }
      let(:planet) {Planet.find_by(name: "andvari")}

      it "updates the requested planet" do
        patch planet_url(planet),
              params: { planet: new_attributes }, headers: valid_headers, as: :json
        planet.reload

        expect(planet.resources_received).to eq({"food"=>10})
      end

      it "renders a JSON response with the planet" do
        Planet.create!({
          name: "andvari",
          resources_sent: {"water": 10},
          resources_received: {"food": 0}
        })
        patch planet_url(planet),
              params: { planet: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      let(:planet){Planet.find_by(name: "andvari")}
      it "renders a JSON response with errors for the planet" do
        Planet.create!({
          name: "andvari",
          resources_sent: {"water": 10},
          resources_received: {"food": 0}
        })
        patch planet_url(planet),
              params: { planet: {name: "andvari", resources_received: "cheese", resources_sent: "cake"} }, headers: valid_headers, as: :json
        # expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end
end
