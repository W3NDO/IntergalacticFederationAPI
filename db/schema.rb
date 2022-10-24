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

ActiveRecord::Schema[7.0].define(version: 2022_10_24_003650) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contracts", force: :cascade do |t|
    t.text "description"
    t.string "payload"
    t.string "origin_planet"
    t.string "destination_planet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "USD", null: false
    t.string "status", default: "open"
    t.integer "financial_transaction_id"
  end

  create_table "financial_transactions", force: :cascade do |t|
    t.text "description"
    t.string "transaction_hash"
    t.integer "amount"
    t.string "ship_name"
    t.string "pilot_certification"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "value_cents", default: 0, null: false
    t.string "value_currency", default: "USD", null: false
    t.integer "pilot_id"
    t.integer "ship_id"
    t.integer "origin_planet_id"
    t.integer "destination_planet_id"
    t.string "transaction_type"
    t.string "transaction_origin_planet"
    t.string "transaction_destination_planet"
  end

  create_table "pilots", force: :cascade do |t|
    t.integer "certification"
    t.string "name"
    t.integer "age"
    t.string "location_planet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "credits_cents", default: 0, null: false
    t.string "credits_currency", default: "USD", null: false
    t.jsonb "totals"
  end

  create_table "planets", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.jsonb "resources_sent"
    t.jsonb "resources_received"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name"
    t.integer "weight"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "contract_id"
  end

  create_table "ships", force: :cascade do |t|
    t.integer "weight_capacity"
    t.integer "fuel_capacity"
    t.integer "fuel_level"
    t.integer "pilot_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
  end

end
