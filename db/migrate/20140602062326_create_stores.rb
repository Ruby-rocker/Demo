class CreateStores < ActiveRecord::Migration
  def change
    create_table :stores do |t|
      t.string :name
      t.references :location, index: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
