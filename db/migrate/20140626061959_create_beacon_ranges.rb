class CreateBeaconRanges < ActiveRecord::Migration
  def change
    create_table :beacon_ranges do |t|
      t.string :name
      t.string :range
      t.boolean :is_active

      t.timestamps
    end
  end
end
