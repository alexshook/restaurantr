require 'csv'

class DataImporter
  def run
    Restaurant.transaction do
      File.open(file_path, "r") do |file|
        CSV.foreach(file, headers: false) do |row|
          if acceptable_thai_restaurant?(row)
            Restaurant.create!(
              name: row[1],
              address: row[2],
              grade: row[14],
              grade_date: grade_date(row[8])
            )
          end
        end
      end
    end
  end

  def file_path
    Rails.root.join("vendor", "nyc_restaurant_inspection_results.csv")
  end

  private

  def acceptable_thai_restaurant?(row)
    return unless row[7] == "Thai"
    row[14] == "A" || row[14] == "B"
  end

  def grade_date(date)
    return unless date
    DateTime.strptime(date, "%m/%d/%Y")
  end
end
