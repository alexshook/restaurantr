class CreateRestaurants < ActiveRecord::Migration[5.1]
  def change
    create_table :restaurants do |t|
      t.string    :name
      t.string    :address
      t.integer   :grade
      t.datetime  :grade_date

      t.timestamps
    end
  end
end
