# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_01_09_190743) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "custom_fields", force: :cascade do |t|
    t.string "field_id", null: false
    t.string "field_label", null: false
    t.string "field_type", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "custom_responses", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "custom_field_id", null: false
    t.string "response"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["custom_field_id"], name: "index_custom_responses_on_custom_field_id"
    t.index ["user_id"], name: "index_custom_responses_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "auth_token", null: false
    t.string "auth_username", null: false
    t.string "auth_user_id", null: false
    t.string "time_zone", null: false
    t.string "avatar"
    t.string "display_name"
    t.string "first_name"
    t.string "last_name"
    t.string "phone_office"
    t.string "what_i_do"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["auth_user_id"], name: "index_users_on_auth_user_id", unique: true
  end

end
