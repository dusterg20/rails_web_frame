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

ActiveRecord::Schema.define(version: 2019_11_02_011608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "access_control_doors", force: :cascade do |t|
    t.string "name"
    t.string "location"
    t.string "description"
    t.string "reader_manuf"
    t.string "reader_model"
    t.string "reader_serial"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_access_control_doors_on_name"
    t.index ["reader_serial"], name: "index_access_control_doors_on_reader_serial", unique: true
  end

  create_table "access_controls", force: :cascade do |t|
    t.string "user_first_name"
    t.string "user_last_name"
    t.string "key_code"
    t.string "access_level"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "description"
    t.string "office_number"
    t.string "badge_holder_phone"
    t.string "badge_holder_email"
    t.index ["description"], name: "index_access_controls_on_description", unique: true
    t.index ["key_code"], name: "index_access_controls_on_key_code", unique: true
  end

  create_table "access_permissions", force: :cascade do |t|
    t.bigint "access_control_id"
    t.bigint "access_control_door_id"
    t.time "sunday"
    t.time "monday"
    t.time "tuesday"
    t.time "wednesday"
    t.time "thursday"
    t.time "friday"
    t.time "saturday"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.time "sunday_end"
    t.time "monday_end"
    t.time "tuesday_end"
    t.time "wednesday_end"
    t.time "thursday_end"
    t.time "friday_end"
    t.time "saturday_end"
    t.index ["access_control_door_id"], name: "index_access_permissions_on_access_control_door_id"
    t.index ["access_control_id"], name: "index_access_permissions_on_access_control_id"
  end

  create_table "devices", force: :cascade do |t|
    t.string "dev_name", limit: 30
    t.string "dev_pi", limit: 30
    t.string "dev_location", limit: 50
    t.integer "dev_pin_count"
    t.integer "dev_pin1"
    t.integer "dev_pin2"
    t.integer "dev_pin3"
    t.integer "dev_pin4"
    t.integer "dev_pin5"
    t.boolean "dev_data"
    t.string "dev_data_type", limit: 30
    t.string "dev_data_char", limit: 5
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "rpi_id"
    t.string "dev_input_signal"
    t.index ["dev_name"], name: "index_devices_on_dev_name", unique: true
    t.index ["rpi_id"], name: "index_devices_on_rpi_id"
  end

  create_table "microposts", id: :serial, force: :cascade do |t|
    t.text "content"
    t.integer "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture"
    t.index ["user_id"], name: "index_microposts_on_user_id"
  end

  create_table "relationships", id: :serial, force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "rpis", force: :cascade do |t|
    t.string "rpi_name", limit: 30
    t.string "rpi_location", limit: 100
    t.string "rpi_ip", limit: 16
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "rpi_model"
    t.index ["rpi_name"], name: "index_rpis_on_rpi_name", unique: true
  end

  create_table "users", id: :serial, force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "password_digest"
    t.string "remember_digest"
    t.boolean "admin", default: false
    t.string "activation_digest"
    t.boolean "activated", default: false
    t.datetime "activated_at"
    t.string "reset_digest"
    t.datetime "reset_sent_at"
    t.string "lname"
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "devices", "rpis"
  add_foreign_key "microposts", "users"
end
