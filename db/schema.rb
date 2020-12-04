# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_12_02_041802) do

  create_table "downloads", force: :cascade do |t|
    t.string "url", null: false
    t.string "status", default: "initial", null: false
    t.string "http_username"
    t.string "http_password"
    t.datetime "queued_at"
    t.datetime "started_at"
    t.datetime "finished_at"
    t.text "error"
    t.datetime "cancelled_at"
    t.string "file_filter"
    t.boolean "audio_only", default: false, null: false
    t.string "audio_format", default: "mp3", null: false
    t.boolean "download_subs", default: false, null: false
    t.boolean "srt_subs", default: false, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.index ["user_id"], name: "index_downloads_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index "\"reset_password_token\"", name: "index_users_on_reset_password_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
  end

  add_foreign_key "downloads", "users"
end
