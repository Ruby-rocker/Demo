class CreateCampaignRules < ActiveRecord::Migration
  def change
    create_table :campaign_rules do |t|
      t.integer :second_welcome_min
      t.integer :second_welcome_hour
      t.integer :message_delay_second
      t.integer :message_delay_min
      t.integer :message_delay_hour
      t.integer :campaign_limit_message
      t.integer :campaign_limit_second
      t.integer :campaign_limit_min
      t.integer :campaign_limit_hour
      t.integer :campaign_limit_days
      t.integer :deactivate_campaign
      t.references :campaign

      t.timestamps
    end
  end
end
