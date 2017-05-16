class AddConstraintsToRestaurants < ActiveRecord::Migration[5.1]
  def change
    change_column_null :restaurants, :name, false
    change_column_null :restaurants, :grade, false
  end
end
