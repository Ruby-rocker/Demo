class CreateContactIbeacons < ActiveRecord::Migration
  def change
    create_table :contact_ibeacons do |t|
      t.integer :ibeacon_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
