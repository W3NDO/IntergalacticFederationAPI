require 'rails_helper'

RSpec.describe Resource, type: :model do
  let(:resource_1) {Resource.new(name: "minerals", weight: 10)}
  let(:resource_2) {Resource.new(name: "water", weight: 10)}
  let(:resource_3) {Resource.new(name: "food", weight: 10)}
  let(:invalid_resource) {Resource.new(name: "food", weight: 0)}
  
  it "ensures that you can only create 3 types of resources" do
    expect{ Resource.new(name: "cheese", weight: 0) }.to raise_error(ArgumentError)

    expect(resource_1.valid?).to be true
    expect(resource_2.valid?).to be true
    expect(resource_3.valid?).to be true
  end

  it "ensures you can't specify weight less than 1" do
    expect(invalid_resource.valid?).to be false
  end

  it "ensures that the enum mappings are correct" do
    expect(resource_1.name).to eq "minerals"
    expect(resource_2.name).to eq "water"
    expect(resource_3.name).to eq "food"
  end
end
