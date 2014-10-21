class CreateAccessModuleRoles < ActiveRecord::Migration
  def change
    create_table :access_module_roles do |t|
      t.integer :access_module_id
      t.integer :role_id

      t.timestamps
    end
  end
end
