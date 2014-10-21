class CreateAdminTemplateMasters < ActiveRecord::Migration
  def change
    create_table :admin_template_masters do |t|
      t.integer :admin_id
      t.integer :template_master_id

      t.timestamps
    end
  end
end
