require 'rails_helper'

RSpec.describe "/pilots", type: :request do
  let(:valid_attributes) {
    {
      certification: 1999984, 
      name: "Kirk", 
      age: 24, 
      location_planet: "calas",
      credits_cents: 120.30
    }
  }

  let(:invalid_attributes) {
    {
      certification: 1999984, 
      name: "Kirk", 
      age: 17, 
      location_planet: "Calas",
      credits_cents: "hello"
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Pilot.create! valid_attributes
      get pilots_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      pilot = Pilot.create! valid_attributes
      get pilot_url(pilot), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new pilot" do
        expect {
          post pilots_url,
               params: { pilot: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Pilot, :count).by(1)
      end

      it "renders a JSON response with the new pilot" do
        post pilots_url,
             params: { pilot: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new pilot" do
        expect {
          post pilots_url,
               params: { pilot: invalid_attributes }, as: :json
        }.to change(Pilot, :count).by(0)
      end

      it "renders a JSON response with errors for the new pilot" do
        post pilots_url,
             params: { pilot: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          certification: 1999984, 
          name: "Jean Luc Piccard", 
          age: 24, 
          location_planet: "Calas",
          credits_cents: 120
        }
      }

      it "updates the requested pilot" do
        pilot = Pilot.create! valid_attributes
        patch pilot_url(pilot),
              params: { pilot: new_attributes }, headers: valid_headers, as: :json
        pilot.reload
        expect(pilot.name).to eq "Jean Luc Piccard"
      end

      it "renders a JSON response with the pilot" do
        pilot = Pilot.create! valid_attributes
        patch pilot_url(pilot),
              params: { pilot: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the pilot" do
        pilot = Pilot.create! valid_attributes
        patch pilot_url(pilot),
              params: { pilot: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested pilot" do
      pilot = Pilot.create! valid_attributes
      expect {
        delete pilot_url(pilot), headers: valid_headers, as: :json
      }.to change(Pilot, :count).by(-1)
    end
  end
end
