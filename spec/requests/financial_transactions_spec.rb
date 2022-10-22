require 'rails_helper'

RSpec.describe "/financial_transactions", type: :request do

  let(:valid_attributes) {
    skip("Add a hash of attributes valid for your model")
  }

  let(:invalid_attributes) {
    skip("Add a hash of attributes invalid for your model")
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

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        skip("Add a hash of attributes valid for your model")
      }

      it "updates the requested financial_transaction" do
        financial_transaction = FinancialTransaction.create! valid_attributes
        patch financial_transaction_url(financial_transaction),
              params: { financial_transaction: new_attributes }, headers: valid_headers, as: :json
        financial_transaction.reload
        skip("Add assertions for updated state")
      end

      it "renders a JSON response with the financial_transaction" do
        financial_transaction = FinancialTransaction.create! valid_attributes
        patch financial_transaction_url(financial_transaction),
              params: { financial_transaction: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the financial_transaction" do
        financial_transaction = FinancialTransaction.create! valid_attributes
        patch financial_transaction_url(financial_transaction),
              params: { financial_transaction: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested financial_transaction" do
      financial_transaction = FinancialTransaction.create! valid_attributes
      expect {
        delete financial_transaction_url(financial_transaction), headers: valid_headers, as: :json
      }.to change(FinancialTransaction, :count).by(-1)
    end
  end
end
