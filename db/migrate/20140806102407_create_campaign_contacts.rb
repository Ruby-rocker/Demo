class CreateCampaignContacts < ActiveRecord::Migration
  def change
    create_table :campaign_contacts do |t|
      t.integer :campaign_id
      t.integer :contact_id

      t.timestamps
    end
  end
end
