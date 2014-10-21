class CreateIbeacons < ActiveRecord::Migration
  def change
    create_table :ibeacons do |t|
      t.string :name
      t.text :description
      t.references :store, index: true
      t.string :broadcast_id
      t.string :uuid
      t.string :major_id
      t.string :minor_id
      t.string :broadcasting_power
      t.string :broadcasting_interval
      t.boolean :is_active

      t.timestamps
    end
  end
end
