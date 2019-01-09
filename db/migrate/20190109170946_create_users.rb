class CreateUsers < ActiveRecord::Migration[5.2]
  def change
    create_table :users do |t|
      t.string :email, null: false
      t.string :auth_token, null: false
      t.string :auth_username, null: false
      t.string :auth_user_id, null: false
      t.string :time_zone, null: false
      t.string :avatar
      t.string :display_name
      t.string :first_name
      t.string :last_name
      t.string :phone_office
      t.string :what_i_do
      t.timestamps
    end
  end
end
