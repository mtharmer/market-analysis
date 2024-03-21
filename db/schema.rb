# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.0].define(version: 2024_03_21_025433) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "bars", force: :cascade do |t|
    t.string "day"
    t.string "time"
    t.bigint "instrument_id", null: false
    t.string "timeframe_measurement"
    t.integer "timeframe_value"
    t.decimal "high", precision: 10, scale: 2
    t.decimal "low", precision: 10, scale: 2
    t.decimal "open", precision: 10, scale: 2
    t.decimal "close", precision: 10, scale: 2
    t.integer "volume"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["instrument_id"], name: "index_bars_on_instrument_id"
  end

  create_table "instruments", force: :cascade do |t|
    t.string "symbol"
    t.string "exchange"
    t.string "asset_class"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.decimal "tick_size"
  end

  create_table "market_profiles", force: :cascade do |t|
    t.string "day"
    t.bigint "instrument_id", null: false
    t.decimal "high", precision: 10, scale: 2
    t.decimal "low", precision: 10, scale: 2
    t.decimal "open", precision: 10, scale: 2
    t.decimal "close", precision: 10, scale: 2
    t.decimal "initial_balance_high", precision: 10, scale: 2
    t.decimal "initial_balance_low", precision: 10, scale: 2
    t.decimal "value_area_high", precision: 10, scale: 2
    t.decimal "value_area_low", precision: 10, scale: 2
    t.decimal "point_of_control", precision: 10, scale: 2
    t.string "day_type"
    t.string "opening_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "total_tpos"
    t.index ["instrument_id"], name: "index_market_profiles_on_instrument_id"
  end

  create_table "tpos", force: :cascade do |t|
    t.bigint "market_profile_id", null: false
    t.decimal "price", precision: 10, scale: 2
    t.text "letters", default: [], array: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["market_profile_id"], name: "index_tpos_on_market_profile_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "bars", "instruments"
  add_foreign_key "market_profiles", "instruments"
  add_foreign_key "tpos", "market_profiles"
end
