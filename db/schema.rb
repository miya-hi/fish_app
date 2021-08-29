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

ActiveRecord::Schema.define(version: 2021_08_11_072401) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "diaries", force: :cascade do |t|
    t.integer "amount", null: false
    t.datetime "input_at", null: false
    t.bigint "user_id", null: false
    t.bigint "fish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_diaries_on_fish_id"
    t.index ["user_id"], name: "index_diaries_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "fish_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["fish_id"], name: "index_favorites_on_fish_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "fish", force: :cascade do |t|
    t.string "name", null: false
    t.string "line", null: false
    t.float "n3_oil", null: false
    t.boolean "n3_oil_no_data"
    t.integer "vitamin_a", null: false
    t.boolean "vitamin_a_tr"
    t.boolean "vitamin_a_no_data"
    t.float "mercury"
    t.text "content"
    t.string "image"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["line"], name: "index_fish_on_line"
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "name", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "admin", default: false, null: false
    t.date "baby_due_on"
    t.index ["name"], name: "index_users_on_name", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "diaries", "fish"
  add_foreign_key "diaries", "users"
  add_foreign_key "favorites", "fish"
  add_foreign_key "favorites", "users"
end
