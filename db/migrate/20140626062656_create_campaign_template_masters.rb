class CreateCampaignTemplateMasters < ActiveRecord::Migration
  def change
    create_table :campaign_template_masters do |t|
      t.integer :campaign_id
      t.integer :template_master_id

      t.timestamps
    end
  end
end
