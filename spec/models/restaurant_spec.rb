require 'rails_helper'

describe Restaurant do
  describe "grade" do
    it "contains the correct grades" do
      expect(Restaurant.grades.keys).to eq(["a", "b"])
    end
  end

  describe ".cuisine" do
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

    context "when given cuisine 'Thai'" do
      it "returns a Thai restaurant" do
        expect(Restaurant.cuisine("Thai")).to eq([thai_restaurant])
      end
    end

    context "when given cuisine 'Bakery'" do
      it "returns a bakery" do
        expect(Restaurant.cuisine("Bakery")).to eq([bakery])
      end
    end

    context "when given a cuisine that does not exist in the database" do
      it "returns []" do
        expect(Restaurant.cuisine("Foo")).to eq([])
      end
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
