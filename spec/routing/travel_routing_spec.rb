require "rails_helper"

RSpec.describe TravelController, type: :routing do
  describe "routing" do
    it "routes to #create" do
      expect(post: "/travel").to route_to("travel#create")
    end
  end
end