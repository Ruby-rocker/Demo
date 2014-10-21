class CreateTemplateMasters < ActiveRecord::Migration
  def change
    create_table :template_masters do |t|
      t.string :name
      t.string :header_text
      t.decimal :amount, :precision => 8, :scale => 2
      t.text :description
      t.string :coupon_code
      t.boolean :is_active

      t.timestamps
    end
  end
end
