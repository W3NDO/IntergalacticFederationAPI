require 'rails_helper'

RSpec.describe "/financial_transactions", type: :request do
  let(:pilot){Pilot.create!(
    name: "Jean Luc Piccard",
    age: rand(18..35),
    location_planet: "calas",
    credits_cents: rand(100..1000),
    certification: 198705)
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
  let(:valid_attributes) {
    {
      description: "Transporting minerals from #{planet_origin.name} to #{planet_destination.name}",
      transaction_type: "resource_transport",
      amount: rand(100..500),
      pilot_id: pilot.id,
      destination_planet_id: planet_destination.id,
      origin_planet_id: planet_origin.id,
      ship_id: ship.id
    }
  }

  let(:invalid_attributes) {
    {
      transaction_type: "fuel_refill",
      amount: rand(100..500),
      pilot_id: pilot.id,
      ship_id: ship.id
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      FinancialTransaction.create! valid_attributes
      get financial_transactions_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      financial_transaction = FinancialTransaction.create! valid_attributes
      get financial_transaction_url(financial_transaction), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new FinancialTransaction" do
        expect(FinancialTransaction.new(valid_attributes).valid?).to be true
        expect {
          post financial_transactions_url,
               params: { financial_transaction: valid_attributes }, headers: valid_headers, as: :json
        }.to change(FinancialTransaction, :count).by(1)
      end

      it "renders a JSON response with the new financial_transaction" do
        post financial_transactions_url,
             params: { financial_transaction: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new FinancialTransaction" do
        expect {
          post financial_transactions_url,
               params: { financial_transaction: invalid_attributes }, as: :json
        }.to change(FinancialTransaction, :count).by(0)
      end

      it "renders a JSON response with errors for the new financial_transaction" do
        post financial_transactions_url,
             params: { financial_transaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "refill" do
    let(:refill_attributes) {
      {
        refill: {
            ship_id: 1,
            planet_id: 2,
            units_of_fuel: 3
        }
      }
    }

    it "raises missing ship error" do
        refill_attributes[:refill][:ship_id] = nil
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Ship is required")
    end

    it "raises missing planet error" do
        refill_attributes[:refill][:planet_id] = nil
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Planet is required")
    end

    it "raises missing destination planet error" do
        refill_attributes[:refill][:units_of_fuel] = nil
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Number of units is required")
    end

    it "returns ship not found error" do
        refill_attributes[:refill][:ship_id] = 999
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Ship does not exist")
    end

    it "returns origin planet not found error" do
        refill_attributes[:refill][:planet_id] = 999
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Planet does not exist")
    end

    it "units not a number error" do
        refill_attributes[:refill][:units_of_fuel] = "cheese"
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Fuel Units is required to be an number")
    end

    let(:pilot) {Pilot.first}
    let(:ship) {Ship.create!(pilot_id: pilot.id, name: "Tempest", fuel_capacity: 30, fuel_level: 10, weight_capacity: 10 )}
    let(:origin_planet) {Planet.create!(name: "aqua", resources_sent: 0, resources_received: 0)}
    it "returns can't afford error" do
        pilot.update!(credits_cents: 10)
        refill_attributes[:refill][:ship_id] = ship.id
        refill_attributes[:refill][:origin_planet_id] = origin_planet.id
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Ship's pilot can not afford to buy #{refill_attributes[:refill][:units_of_fuel]} units of fuel")
    end

    it "returns successful travel" do
        post refill_url, params: refill_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
    end
  end
end
