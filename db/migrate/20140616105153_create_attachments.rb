class CreateAttachments < ActiveRecord::Migration
  def self.up
    create_table :attachments do |t|
      t.attachment :attachment
      t.attachment :attachment_icon
      t.attachment :attachment_audio
      t.attachment :pem_certi
      t.references  :attachable, polymorphic: true
      t.timestamps
    end
    add_index :attachments, [:attachable_id, :attachable_type]
  end

  def self.down
    drop_attached_file :attachments, :attachment
  end
end
