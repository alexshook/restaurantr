require 'rails_helper'

describe "searching by cuisine", :type => :feature do
  describe "case insensitive search" do
    before do
      Restaurant.create!(
          cuisine: "Thai",
          name: "Some Restaurant",
          grade: "a",
          grade_date: Time.now
      )

      Restaurant.create!(
        cuisine: "Bakery",
        name: "Some Bakery",
        grade: "a",
        grade_date: Time.now
      )
    end

    context "when given cuisine 'Bakery'" do
      it "displays bakery results" do
        visit root_path
        fill_in "cuisine", with: "Bakery"
        click_button "Search"

        expect(page).to have_content "Some Bakery"
      end
    end

    context "when given cuisine 'bakery'" do
      it "displays bakery results" do
        visit root_path
        fill_in "cuisine", with: "bakery"
        click_button "Search"

        expect(page).to have_content "Some Bakery"
      end
    end

    describe "when no results are found" do
      it "displays an error message" do
        visit root_path
        fill_in "cuisine", with: "foo"
        click_button "Search"

        expect(page).to have_content "Sorry, no restaurants found. Please try another type of cuisine!"
      end
    end
  end
end
