require 'rails_helper'

RSpec.describe "/resources", type: :request do

  let(:valid_attributes) {
    {
      name: "water",
      weight: 10
    }
  }

  let(:invalid_attributes) {
    {
      name: "minerals", 
      weight: 0
    }
  }

  let(:valid_headers) {
    {}
  }

  describe "GET /index" do
    it "renders a successful response" do
      Resource.create! valid_attributes
      get resources_url, headers: valid_headers, as: :json
      expect(response).to be_successful
    end
  end

  describe "GET /show" do
    it "renders a successful response" do
      resource = Resource.create! valid_attributes
      get resource_url(resource), as: :json
      expect(response).to be_successful
    end
  end

  describe "POST /create" do
    context "with valid parameters" do
      it "creates a new Resource" do
        expect {
          post resources_url,
               params: { resource: valid_attributes }, headers: valid_headers, as: :json
        }.to change(Resource, :count).by(1)
      end

      it "renders a JSON response with the new resource" do
        post resources_url,
             params: { resource: valid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:created)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "does not create a new Resource" do
        expect {
          post resources_url,
               params: { resource: invalid_attributes }, as: :json
        }.to change(Resource, :count).by(0)
      end

      it "renders a JSON response with errors for the new resource" do
        post resources_url,
             params: { resource: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "PATCH /update" do
    context "with valid parameters" do
      let(:new_attributes) {
        {
          name: "minerals", 
          weight: 100
        }
      }

      it "updates the requested resource" do
        resource = Resource.create! valid_attributes
        patch resource_url(resource),
              params: { resource: new_attributes }, headers: valid_headers, as: :json
        resource.reload
        expect(resource.weight).to eq 100
      end

      it "renders a JSON response with the resource" do
        resource = Resource.create! valid_attributes
        patch resource_url(resource),
              params: { resource: new_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end

    context "with invalid parameters" do
      it "renders a JSON response with errors for the resource" do
        resource = Resource.create! valid_attributes
        patch resource_url(resource),
              params: { resource: invalid_attributes }, headers: valid_headers, as: :json
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to match(a_string_including("application/json"))
      end
    end
  end

  describe "DELETE /destroy" do
    it "destroys the requested resource" do
      resource = Resource.create! valid_attributes
      expect {
        delete resource_url(resource), headers: valid_headers, as: :json
      }.to change(Resource, :count).by(-1)
    end
  end
end
