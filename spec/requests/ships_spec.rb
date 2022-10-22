require 'rails_helper'

RSpec.describe "/ships", type: :request do
  let(:pilot){Pilot.create!(certification: 199877, name: "Kirk", age: 24, location_planet: "Calas")}
  let(:valid_attributes) {
    {
      weight_capacity: 100, 
      fuel_capacity: 120, 
      fuel_level: 80, 
      name: "Normandy",
      pilot_id: pilot.id
    }
  }

  let(:invalid_attributes) {
    {
      weight_capacity: 100, 
      fuel_capacity: 120, 
      fuel_level: -1, 
      pilot_id: pilot.id
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Ship.create! valid_attributes
      get ships_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      ship = Ship.create! valid_attributes
      get ship_url(ship), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new ship" do
        expect {
          post ships_url,
               params: { ship: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Ship, :count).by(1)
      end

      it "renders a JSON response with the new ship" do
        post ships_url,
             params: { ship: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new ship" do
        expect {
          post ships_url,
               params: { ship: invalid_attributes }, as: :json
        }.to change(Ship, :count).by(0)
      end

      it "renders a JSON response with errors for the new ship" do
        post ships_url,
             params: { ship: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          weight_capacity: 100, 
          fuel_capacity: 120, 
          fuel_level: 60, 
          pilot_id: pilot.id
        }
      }

      it "updates the requested ship" do
        ship = Ship.create! valid_attributes
        patch ship_url(ship),
              params: { ship: new_attributes }, headers: valid_headers, as: :json
        ship.reload
        expect(ship.fuel_level).to eq 60 
      end

      it "renders a JSON response with the ship" do
        ship = Ship.create! valid_attributes
        patch ship_url(ship),
              params: { ship: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the ship" do
        ship = Ship.create! valid_attributes
        patch ship_url(ship),
              params: { ship: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested ship" do
      ship = Ship.create! valid_attributes
      expect {
        delete ship_url(ship), headers: valid_headers, as: :json
      }.to change(Ship, :count).by(-1)
    end
  end
end

