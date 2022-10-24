require 'rails_helper'

RSpec.describe "/travel", type: :request do
    let(:valid_attributes) {
        {
            "ship_id": 1,
            "origin_planet_id": 2,
            "destination_planet_id": 3
        }
    }
    let(:invalid_attributes){
        {
            "ship_id": 1,
            "origin_planet_id": 5,
            "destination_planet_id": 6
        }
    }

    it "raises missing ship error" do
        valid_attributes[:ship_id] = nil
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Ship is required")
    end

    it "raises missing origin planet error" do
        valid_attributes[:origin_planet_id] = nil
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Origin Planet is required")
    end

    it "raises missing destination planet error" do
        valid_attributes[:destination_planet_id] = nil
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Destination Planet is required")
    end

    it "raises origin planet can not be the same as destination planet error" do
        valid_attributes[:origin_planet_id] = valid_attributes[:destination_planet_id]
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Origin Planet can not be the same as destination planet")
    end

    it "returns ship not found error" do
        valid_attributes[:ship_id] = 999
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Ship does not exist")
    end

    it "returns origin planet not found error" do
        valid_attributes[:origin_planet_id] = 999
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Origin Planet does not exist")
    end

    it "returns destination planet not found error" do
        valid_attributes[:destination_planet_id] = 999
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Destination Planet does not exist")
    end

    let(:pilot) {Pilot.create!(name: "Mercer", certification: 1989860, location_planet:"aqua", credits_cents: 420, age: 19, totals: {})}
    let(:ship) {Ship.create!(pilot_id: pilot.id, name: "Tempest", fuel_capacity: 30, fuel_level: 1, weight_capacity: 10 )}
    let(:origin_planet) {Planet.create!(name: "aqua", resources_sent: 0, resources_received: 0)}
    let(:destination_planet) {Planet.create!(name: "demeter", resources_sent: 0, resources_received: 0)}
    it "returns low fuel error" do
        valid_attributes[:ship_id] = ship.id
        valid_attributes[:origin_planet_id] = origin_planet.id
        valid_attributes[:destination_planet_id] = destination_planet.id
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
        body = JSON.parse(response.body)
        expect(body["error"]).to eq("Unable to travel from aqua to demeter due to low fuel")
    end

    it "returns successful travel" do
        post travel_url, params: valid_attributes, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
    end
end