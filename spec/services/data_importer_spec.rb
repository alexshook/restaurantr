require 'rails_helper'

describe DataImporter do
  describe "GRADE_MAPPING" do
    it "contains the correct grade mapping" do
      expect(DataImporter::GRADE_MAPPING).to eq({"A"=>"a", "B"=>"b"})
    end
  end

  let(:data_importer) { DataImporter.new }

  describe "#run" do
    context "when the import is successful" do
      let(:test_file) do
        Rails.root.join("spec", "fixtures", "test_restaurants.csv")
      end

      before do
        data_importer.stub(:file_path).and_return(test_file)
      end

      it "adds the three matching restaurants to the database" do
        expect do
          data_importer.run
        end.to change { Restaurant.count }.by(3)
      end

      it "has only restaurants with grades A and B" do
        data_importer.run
        expect(Restaurant.pluck(:grade)).to eq(["a", "a", "b"])
      end

      describe "the first restaurant" do
        let(:restaurant) { Restaurant.first }

        it "has the correct attributes" do
          data_importer.run
          expect(restaurant.name).to eq("Lemongrass Grill")
          expect(restaurant.address).
            to eq("156 Court Street, Brooklyn, NY 11201")
          expect(restaurant.grade).to eq("a")
          expect(restaurant.grade_date).
            to eq("Mon, 01 Jan 1900 00:00:00 UTC +00:00")
          expect(restaurant.cuisine).to eq("Thai")

        end
      end
    end

    context "when the import fails" do
      let(:test_file) do
        Rails.root.join("spec", "fixtures", "bad_data_test_file.csv")
      end

      before do
        data_importer.stub(:file_path).and_return(test_file)
      end

      it "does not add any restaurants to the database" do
        expect do
          data_importer.run
        end.to_not change { Restaurant.count }
      end
    end
  end

  describe "#file_path" do
    it "has the correct directory and file name" do
      expect(data_importer.file_path.to_s).
        to include("vendor/nyc_restaurant_inspection_results")
    end
  end
end
