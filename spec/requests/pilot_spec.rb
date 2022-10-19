require 'rails_helper'

RSpec.describe "Pilots", type: :request do
  describe "POST /pilots" do
    it "creates a new pilot" do
      post '/pilots', params: {
        pilot: {
          certification: 199992, 
          name: "Kirk", 
          age: 24, 
          location_planet: "Calas"
        }
      }
      response_body = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(Pilot.count).to eq 1
      expect(response_body["message"]).to eq("Pilot successfully created")
    end
  end

  describe "GET /pilots/:id" do
    it "returns the pilot if they are found" do
      post '/pilots', params: {
        pilot: {
          certification: 199992, 
          name: "Kirk", 
          age: 24, 
          location_planet: "Calas"
        }
      }

      get "/pilots/#{Pilot.last.id}"
      expect(response).to have_http_status(:success)
    end

    xit "returns a 404 if no pilot is found" do
      get "/pilots/10"
      expect(response).to have_http_status(:not_found)
    end
  end

  describe "GET /index" do
    it "returns an array of all pilots" do
      get '/pilots'
      json_response = JSON.parse(response.body)
      expect(response).to have_http_status(:success)
      expect(json_response.length).to eq Pilot.all.size
    end
  end

  describe "PUT /pilots/:id" do
    it "updates an existing pilot" do
      post '/pilots', params: {
        pilot: {
          certification: 199992, 
          name: "Kirk", 
          age: 24, 
          location_planet: "Calas"
        }
      }
      put  "/pilots/#{Pilot.last.id}", params: {
        pilot: {
          certification: 199992, 
          name: "Kirk", 
          age: 32, 
          location_planet: "Calas"
        }
      }
      json_response = JSON.parse(response.body)
      expect(json_response["data"]["age"]).to eq 32
    end
  end

  describe "DELETE /pilots/:id" do

    it "deletes a pilot" do
      post '/pilots', params: {
        pilot: {
          certification: 199992, 
          name: "Kirk", 
          age: 24, 
          location_planet: "Calas"
        }
      }
      expect(Pilot.last).to_not be nil

      delete "/pilots/#{Pilot.last.id}"
      expect(Pilot.last).to be nil
    end

  end
end
