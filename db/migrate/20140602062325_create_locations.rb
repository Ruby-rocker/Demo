class CreateLocations < ActiveRecord::Migration
  def change
    create_table :locations do |t|
      t.string :name
      t.string :zipcode
      t.boolean :is_active

      t.timestamps
    end
  end
end
