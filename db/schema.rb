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

ActiveRecord::Schema.define(version: 2019_04_02_114736) do

  create_table "categories", force: :cascade do |t|
    t.integer "shop_id"
    t.string "feature_1"
    t.string "feature_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "opening_hours", force: :cascade do |t|
    t.integer "shop_id"
    t.string "day_of_the_week"
    t.string "open_time_1"
    t.string "close_time_1"
    t.string "open_time_2"
    t.string "close_time_2"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shops", force: :cascade do |t|
    t.string "genre"
    t.string "shop_name"
    t.float "tabelog_review"
    t.float "google_review"
    t.integer "seat"
    t.string "table"
    t.string "holiday"
    t.integer "reference_price"
    t.string "reference_menu"
    t.string "image_file_name"
    t.string "reserve"
    t.string "telephone_number"
    t.string "latitude"
    t.string "longnitude"
    t.string "google_map_url"
    t.string "tabelog_url"
    t.string "official_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "line_user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "users_shops", force: :cascade do |t|
    t.string "message"
    t.integer "want_to_visit", default: 0
    t.boolean "_button_pushed", default: false
    t.integer "user_id"
    t.integer "shop_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
