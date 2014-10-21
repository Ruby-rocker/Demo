class CreateAttachmentStores < ActiveRecord::Migration
  def change
    create_table :attachment_stores do |t|
      t.integer :attachment_id
      t.integer :store_id

      t.timestamps
    end
  end
end
