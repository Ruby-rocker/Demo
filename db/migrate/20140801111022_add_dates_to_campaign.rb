class AddDatesToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :schedule_from, :timestamp
    add_column :campaigns, :schedule_to, :timestamp
  end
end
