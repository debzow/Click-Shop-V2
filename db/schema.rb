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

ActiveRecord::Schema.define(version: 2019_01_03_140740) do

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

  create_table "ingredient_type_restrictions", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ingredient_type_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_type_id"], name: "index_ingredient_type_restrictions_on_ingredient_type_id"
    t.index ["user_id"], name: "index_ingredient_type_restrictions_on_user_id"
  end

  create_table "ingredient_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ingredients", force: :cascade do |t|
    t.bigint "ingredient_type_id"
    t.bigint "store_section_id"
    t.bigint "quantity_type_id"
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_type_id"], name: "index_ingredients_on_ingredient_type_id"
    t.index ["quantity_type_id"], name: "index_ingredients_on_quantity_type_id"
    t.index ["store_section_id"], name: "index_ingredients_on_store_section_id"
  end

  create_table "meal_carts", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_meal_carts_on_user_id"
  end

  create_table "meal_carts_meals", id: false, force: :cascade do |t|
    t.bigint "meal_cart_id"
    t.bigint "meal_id"
    t.index ["meal_cart_id"], name: "index_meal_carts_meals_on_meal_cart_id"
    t.index ["meal_id"], name: "index_meal_carts_meals_on_meal_id"
  end

  create_table "meal_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "meals", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meal_type_id"
    t.string "name"
    t.text "description"
    t.text "receipe"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "picture_url"
    t.index ["meal_type_id"], name: "index_meals_on_meal_type_id"
    t.index ["user_id"], name: "index_meals_on_user_id"
  end

  create_table "meals_ustensils", id: false, force: :cascade do |t|
    t.bigint "ustensil_id"
    t.bigint "meal_id"
    t.index ["meal_id"], name: "index_meals_ustensils_on_meal_id"
    t.index ["ustensil_id"], name: "index_meals_ustensils_on_ustensil_id"
  end

  create_table "quantities", force: :cascade do |t|
    t.bigint "meal_id"
    t.bigint "ingredient_id"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_quantities_on_ingredient_id"
    t.index ["meal_id"], name: "index_quantities_on_meal_id"
  end

  create_table "quantity_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shopping_lists", force: :cascade do |t|
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_shopping_lists_on_user_id"
  end

  create_table "shopping_lists_details", force: :cascade do |t|
    t.bigint "shopping_list_id"
    t.bigint "ingredient_id"
    t.float "quantity"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ingredient_id"], name: "index_shopping_lists_details_on_ingredient_id"
    t.index ["shopping_list_id"], name: "index_shopping_lists_details_on_shopping_list_id"
  end

  create_table "store_sections", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "user_meal_favorits", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_user_meal_favorits_on_meal_id"
    t.index ["user_id"], name: "index_user_meal_favorits_on_user_id"
  end

  create_table "user_meal_histories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "meal_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["meal_id"], name: "index_user_meal_histories_on_meal_id"
    t.index ["user_id"], name: "index_user_meal_histories_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "username", default: "", null: false
    t.string "first_name"
    t.string "last_name"
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.integer "household"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  create_table "users_ustensils", id: false, force: :cascade do |t|
    t.bigint "ustensil_id"
    t.bigint "user_id"
    t.index ["user_id"], name: "index_users_ustensils_on_user_id"
    t.index ["ustensil_id"], name: "index_users_ustensils_on_ustensil_id"
  end

  create_table "ustensils", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "ingredient_type_restrictions", "ingredient_types"
  add_foreign_key "ingredient_type_restrictions", "users"
  add_foreign_key "meal_carts", "users"
  add_foreign_key "shopping_lists", "users"
end
