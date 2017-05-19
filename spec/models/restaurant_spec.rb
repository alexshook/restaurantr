require 'rails_helper'

describe Restaurant do
  describe "grade" do
    it "contains the correct grades" do
      expect(Restaurant.grades.keys).to eq(["a", "b"])
    end
  end

  describe ".thai" do
    let!(:thai_restaurant) do
      Restaurant.create!(
        cuisine: "Thai",
        name: "Some Restaurant",
        grade: "a"
      )
    end

    let!(:bakery) do
      Restaurant.create!(
        cuisine: "Bakery",
        name: "Some Bakery",
        grade: "a"
      )
    end

    it "returns a Thai restaurant" do
      expect(Restaurant.thai).to eq([thai_restaurant])
    end
  end

  describe ".recently_graded" do
    let!(:thai_restaurant) do
      Restaurant.create!(
        cuisine: "Thai",
        name: "Some Restaurant",
        grade: "a",
        grade_date: Time.now
      )
    end

    let!(:bakery) do
      Restaurant.create!(
        cuisine: "Bakery",
        name: "Some Bakery",
        grade: "a",
        grade_date: Time.now.yesterday
      )
    end

    it "orders restaurants by grade_date descending" do
      expect(Restaurant.recently_graded).to eq([thai_restaurant, bakery])
    end
  end
end
