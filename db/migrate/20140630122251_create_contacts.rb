class CreateContacts < ActiveRecord::Migration
  def change
    create_table :contacts do |t|
      t.string :uuid
      t.string :udid
      t.string :first_name
      t.string :last_name
      t.string :email_address
      t.string :contact_no
      t.string :latitude
      t.string :longitude

      t.timestamps
    end
  end
end
