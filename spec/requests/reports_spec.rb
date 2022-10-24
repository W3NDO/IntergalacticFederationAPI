require 'rails_helper'

RSpec.describe "Reports", type: :request do
  describe 'get /reports' do
    it "returns a list of all financial transactions sorted by date" do
      get reports_url, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get /reports/pilots' do
    it "returns a list of all pilots and their transaction totals" do
      get reports_pilots_url, as: :json
      expect(response).to have_http_status(:ok)
    end
  end

  describe 'get /reports/planets' do
    it "returns a list of all planets and their resources sent and received totals" do
      get reports_planets_url, as: :json
      expect(response).to have_http_status(:ok)
    end
  end
end
