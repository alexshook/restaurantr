class Restaurant < ApplicationRecord
  enum grade: %w(a b)

  scope :cuisine, -> (cuisine) { where(cuisine: cuisine) }
  scope :recently_graded, -> { order(grade_date: :desc) }
end
