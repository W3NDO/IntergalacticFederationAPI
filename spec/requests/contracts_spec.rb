require 'rails_helper'

RSpec.describe "/contracts", type: :request do

  let(:valid_attributes) {
    {
      :description=> "Kirk moved minerals worth 300 from Calas to Andvari",
      :status => "open",
      :payload=> "minerals",
      :origin_planet=> "calas",
      :destination_planet=> "andvari",
      :value_cents=> 300,
      :resources_attributes =>{
        name: "water",
        weight: 200
      }
    }
  }

  let(:invalid_attributes) {
    {
      :description=> "Kirk moved minerals worth 300 from Calas to Andvari",
      :payload=> "element zero",
      :origin_planet=> "calas",
      :destination_planet=> "dathomir",
      :value_cents=> -1,
      :status => "open",
      :resources_attributes =>{
        name: "water",
        weight: 200
      }
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Contract.create! valid_attributes.except(:resources_attributes)
      get contracts_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    let(:contract){Contract.create! valid_attributes.except(:resources_attributes)}
    it "renders a successful response" do
      Contract.create! valid_attributes.except(:resources_attributes)
      get contract_url(contract.id), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Contract" do
        expect {
          post contracts_url,
               params: { contract: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Contract, :count).by(1)
      end

      it "renders a JSON response with the new contract" do
        post contracts_url,
             params: { contract: valid_attributes}, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Contract" do
        expect {
          post contracts_url,
               params: { contract: invalid_attributes }, as: :json
        }.to change(Contract, :count).by(0)
      end

      it "renders a JSON response with errors for the new contract" do
        post contracts_url,
             params: { contract: invalid_attributes.except(:resources_attributes) }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          :description=> "Kirk moved food worth 500 from Calas to Andvari",
          :payload=> "minerals",
          :origin_planet=> "calas",
          :destination_planet=> "andvari",
          :value_cents=> 40,
          :status => "closed",
          :resources_attributes =>{
            name: "water",
            weight: 200
          }
        }
      }

      it "updates the requested contract" do
        contract = Contract.first
        patch contract_url(contract),
              params: { contract: new_attributes.except(:resources_attributes) }, headers: valid_headers, as: :json
        contract.reload
        expect(contract.description).to eq "Kirk moved food worth 500 from Calas to Andvari"
      end

      it "renders a JSON response with the contract" do
        contract = Contract.create! valid_attributes.except(:resources_attributes)
        patch contract_url(contract),
              params: { contract: new_attributes.except(:resources_attributes) }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the contract" do
        contract = Contract.create! valid_attributes.except(:resources_attributes)
        patch contract_url(contract),
              params: { contract: invalid_attributes.except(:resources_attributes) }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested contract" do
      contract = Contract.create! valid_attributes.except(:resources_attributes)
      expect {
        delete contract_url(contract), headers: valid_headers, as: :json
      }.to change(Contract, :count).by(-1)
    end
  end

  describe "POST /contracts/accept" do
    let(:contract){Contract.create!(
      :description=> "Kirk moved food worth 120 from Calas to Andvari",
      :payload=> "food",
      :origin_planet=> "calas",
      :destination_planet=> "andvari",
      :value_cents=> 40,
      :status => "open",)
    }
    let(:resource){Resource.create!(
      {
        name: "food",
        weight: 120,
        contract_id: contract.id
      })
    }
    let(:pilot){Pilot.create!(
      certification: 1999083, 
      name: "Kirk", 
      age: 24, 
      location_planet: "Calas", 
      credits_cents: 300)      
    }
    let(:ship){Ship.create!(
      name: "Tempest",
      weight_capacity: 100,
      fuel_capacity: 300,
      fuel_level: 100,
      pilot_id: pilot.id
    )}
    
    let(:accept_attributes){
      {
        contract:{
          pilot_id: pilot.id,
          contract_id: contract.id
        }
      }
    }

    let(:pilot_missing){
      {
        contract:{
          contract_id: contract.id
        }
      }
    }
    let(:contract_missing){
      {
        contract:{
          pilot_id: pilot.id
        }
      }
    }

    it "rasises pilot required error" do
      post contracts_accept_url(pilot_missing), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("A pilot is required")
    end

    it "raises contract required error" do
      post contracts_accept_url(contract_missing), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("A contract is required")
    end

    it "return pilot not found error" do
      accept_attributes[:contract][:pilot_id] = 999
      post contracts_accept_url(accept_attributes), as: :json
      expect(response).to have_http_status(:not_found)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Pilot does not exist")
    end

    it "returns contract not found error" do
      accept_attributes[:contract][:contract_id] = 999
      post contracts_accept_url(accept_attributes), as: :json
      expect(response).to have_http_status(:not_found)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Contract does not exist")
    end

    xit "raises contract closed error" do
      contract.closed!
      post contracts_accept_url(accept_attributes), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Contract can not be accepted as it is already closed")
    end

    it "raises contract already active error" do
      contract.active!
      post contracts_accept_url(accept_attributes), as: :json
      expect(response).to have_http_status(:unprocessable_entity)
      body = JSON.parse(response.body)
      expect(body["error"]).to eq("Contract is already being executed")
    end

    describe "contract is accepted" do
      let(:contract){Contract.create!(
        :description=> "Kirk moved food worth 120 from Calas to Andvari",
        :payload=> "food",
        :origin_planet=> "calas",
        :destination_planet=> "andvari",
        :value_cents=> 40,
        :status => "open",)
      }
      let(:resource){Resource.create!(
        {
          name: "food",
          weight: 120,
          contract_id: contract.id
        })
      }
      let(:pilot){Pilot.create!(
        certification: 1999083, 
        name: "Kirk", 
        age: 24, 
        location_planet: "calas", 
        credits_cents: 300)      
      }
      let(:ship){Ship.create!(
        name: "Tempest",
        weight_capacity: 100,
        fuel_capacity: 300,
        fuel_level: 100,
        pilot_id: pilot.id
      )}
      
      let(:accept_attributes){
        {
          contract:{
            pilot_id: pilot.id,
            contract_id: contract.id
          }
        }
      }

      it "changes the pilots location" do
        contract.open!
        pilot.ship = ship
        post contracts_accept_url(accept_attributes), as: :json
        pilot.reload
        expect(response).to have_http_status(:ok)
        expect(pilot.location_planet).to eq("andvari")
      end
      

      it "creates a new transaction" do
        contract.open!
        pilot.ship = ship
        expect {
          post contracts_accept_url(accept_attributes), as: :json
        }.to change(FinancialTransaction, :count).by(1)
      end

      it "changes the contract status to active" do
        contract.open!
        pilot.ship = ship
        post contracts_accept_url(accept_attributes), as: :json
        contract.reload
        expect(response).to have_http_status(:ok)
        expect(contract.active?).to be true
      end

      xit "changes the origin planets sent status" do
      end

    end
  end

  describe "POST /fulfil" do
    xit "rasises pilot required error" do
    end

    xit "raises contract required error" do
    end

    xit "return pilot not found error" do
    end

    xit "returns contract not found error" do
    end

    xit "return pilot not on planet error" do
    end

    xit "raises contract closed error" do
    end

    xit "raises contract open error" do
    end

    describe "contract is fulfilled" do
      xit "changes the pilots credit" do
      end

      xit "changes the transaction description" do
      end

      xit "changes the contract status to closed" do
      end

      xit "changes the destination planet received status" do
      end

    end
  end
end
