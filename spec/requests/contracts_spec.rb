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

  describe "POST /accept" do
    xit "rasises pilot required error" do
    end

    xit "raises contract required error" do
    end

    xit "return pilot not found error" do
    end

    xit "returns contract not found error" do
    end

    xit "raises travel blocked error" do
    end

    xit "raises not enough fuel error" do
    end

    xit "raises contract closed error" do
    end

    xit "raises contract already active error" do
    end

    describe "contract is accepted" do
      xit "changes the ship fuel level" do
      end

      xit "changes the pilots location" do
      end

      xit "creates a new transaction" do
      end

      xit "changes the contract status to active" do
      end

      xit "changes the origin planets sent" do
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
