require "rails_helper"

RSpec.describe FinancialTransactionsController, type: :routing do
  describe "routing" do
    it "routes to #index" do
      expect(get: "/financial_transactions").to route_to("financial_transactions#index")
    end

    it "routes to #show" do
      expect(get: "/financial_transactions/1").to route_to("financial_transactions#show", id: "1")
    end


    it "routes to #create" do
      expect(post: "/financial_transactions").to route_to("financial_transactions#create")
    end

    it "routes to #update via PUT" do
      expect(put: "/financial_transactions/1").to route_to("financial_transactions#update", id: "1")
    end

    it "routes to #update via PATCH" do
      expect(patch: "/financial_transactions/1").to route_to("financial_transactions#update", id: "1")
    end

    it "routes to #destroy" do
      expect(delete: "/financial_transactions/1").to route_to("financial_transactions#destroy", id: "1")
    end
  end
end
