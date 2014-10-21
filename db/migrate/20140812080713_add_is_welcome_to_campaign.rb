class AddIsWelcomeToCampaign < ActiveRecord::Migration
  def change
    add_column :campaigns, :is_welcome, :boolean
  end
end
