require 'csv'

class DataImporter
  GRADE_MAPPING = {
    "A" => "a",
    "B" => "b"
  }

  def run
    Restaurant.transaction do
      File.open(file_path, "r") do |file|
        CSV.foreach(file, headers: false) do |row|
          if acceptable_grade_restaurant?(row[14])
            Restaurant.create!(
              name: row[1].titleize,
              address: assemble_address(row),
              grade: GRADE_MAPPING[row[14]],
              grade_date: grade_date(row[8]),
              cuisine: row[7]
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

  def acceptable_grade_restaurant?(grade)
    ["A", "B"].include?(grade)
  end

  def assemble_address(row)
    [street_address(row), borough_state_zip_code(row)].join(", ")
  end

  def street_address(row)
    [row[3], row[4]].join(" ").titleize
  end

  def borough_state_zip_code(row)
    row[2].titleize + ", NY " + row[5]
  end

  def grade_date(date)
    return unless date
    DateTime.strptime(date, "%m/%d/%Y")
  end
end
