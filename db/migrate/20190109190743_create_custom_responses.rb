class CreateCustomResponses < ActiveRecord::Migration[5.2]
  def change
    create_table :custom_responses do |t|
      t.belongs_to :user, index: true, null: false
      t.belongs_to :custom_field, index: true, null: false
      t.string :response
      t.timestamps
    end
  end
end
