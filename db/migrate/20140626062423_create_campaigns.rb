class CreateCampaigns < ActiveRecord::Migration
  def change
    create_table :campaigns do |t|
      t.string :title
      t.string :name
      t.text :description
      t.references :store, index: true
      t.references :ibeacon, index: true
      t.references :category, index: true
      t.boolean :is_active

      t.timestamps
    end
  end
end
