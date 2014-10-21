class CreateCampaignBeaconRanges < ActiveRecord::Migration
  def change
    create_table :campaign_beacon_ranges do |t|
      t.integer :campaign_id
      t.integer :beacon_range_id

      t.timestamps
    end
  end
end
