require "rails_helper"

RSpec.describe ReportsController, type: :routing do
  describe "routing" do
    it "routes to #full_report" do
      expect(get: "/reports").to route_to("reports#full_report")
    end

    it "routes to #get_pilots_report" do
        expect(get: "/reports/pilots").to route_to("reports#get_pilots_report")
    end

    it "routes to #get_planets_report" do
        expect(get: "/reports/planets").to route_to("reports#get_planets_report")
    end
  end
end