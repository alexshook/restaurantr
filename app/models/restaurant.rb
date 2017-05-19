class Restaurant < ApplicationRecord
  enum grade: %w(a b)

  scope :thai, -> { where(cuisine: "Thai") }
  scope :recently_graded, -> { order(grade_date: :desc) }
end
