class Restaurant < ApplicationRecord
  enum grade: %w(a b)

  scope :cuisine, -> (cuisine) { where("lower(cuisine) = ?", cuisine.downcase) }
  scope :recently_graded, -> { order(grade_date: :desc) }
end
