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

ActiveRecord::Schema.define(version: 2021_12_02_091906) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "assets", force: :cascade do |t|
    t.string "id_name"
    t.integer "rank"
    t.string "name"
    t.string "symbol"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dashboards", force: :cascade do |t|
    t.string "name"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.text "asset"
    t.index ["user_id"], name: "index_dashboards_on_user_id"
  end

  create_table "notes", force: :cascade do |t|
    t.date "date"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_notes_on_user_id"
  end

  create_table "price_histories", force: :cascade do |t|
    t.string "id_name"
    t.date "date"
    t.float "price"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "asset_id", null: false
    t.index ["asset_id"], name: "index_price_histories_on_asset_id"
  end

  create_table "ressources", force: :cascade do |t|
    t.text "name"
    t.text "description"
    t.text "category"
    t.string "link"
  end

  create_table "transactions", force: :cascade do |t|
    t.string "direction"
    t.string "asset_name"
    t.float "quantity"
    t.float "price"
    t.date "date"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "dashboard_id", null: false
    t.bigint "asset_id", null: false
    t.index ["asset_id"], name: "index_transactions_on_asset_id"
    t.index ["dashboard_id"], name: "index_transactions_on_dashboard_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  create_table "votes", force: :cascade do |t|
    t.bigint "users_id", null: false
    t.bigint "ressources_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["ressources_id"], name: "index_votes_on_ressources_id"
    t.index ["users_id"], name: "index_votes_on_users_id"
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "dashboards", "users"
  add_foreign_key "notes", "users"
  add_foreign_key "price_histories", "assets"
  add_foreign_key "transactions", "assets"
  add_foreign_key "transactions", "dashboards"
  add_foreign_key "votes", "ressources", column: "ressources_id"
  add_foreign_key "votes", "users", column: "users_id"
end
