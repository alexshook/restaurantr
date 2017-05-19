require 'rails_helper'

describe RestaurantsController do
  describe "#index" do
    context "when searching for restaurants" do
      it "returns 200" do
        get :index, params: { cuisine: "american" }
        expect(response.status).to eq(200)
      end
    end

    context "when not searching for restaurants" do
      it "returns 200" do
        get :index
        expect(response.status).to eq(200)
      end
    end
  end
end
