class Restaurant < ApplicationRecord
  enum grade: %w(a b)
end
