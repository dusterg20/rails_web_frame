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

ActiveRecord::Schema.define(version: 2019_09_17_202110) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

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
    t.bigint "device_id"
    t.index ["device_id"], name: "index_rpis_on_device_id"
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
