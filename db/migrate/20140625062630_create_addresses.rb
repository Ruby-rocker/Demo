class CreateAddresses < ActiveRecord::Migration
  def change
    create_table :addresses do |t|
      t.references :admin, index: true
      t.string :street
      t.string :suit
      t.string :city
      t.string :state
      t.string :country
      t.string :zip_code

      t.timestamps
    end
  end
end
