require 'rails_helper'

describe Restaurant do
  describe "grade" do
    it "contains the correct grades" do
      expect(Restaurant.grades.keys).to eq(["a", "b"])
    end
  end
end
