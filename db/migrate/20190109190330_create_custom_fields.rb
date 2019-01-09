class CreateCustomFields < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_fields do |t|
      t.string :field_id, null: false
      t.string :field_label, null: false
      t.string :field_type, null: false
      t.timestamps
    end
  end
end
