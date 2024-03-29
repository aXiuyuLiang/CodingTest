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

ActiveRecord::Schema[7.0].define(version: 2024_01_21_213029) do
  create_table "customers", primary_key: "customer_id", id: :string, force: :cascade do |t|
    t.string "name"
    t.integer "current_rank"
    t.datetime "rank_start_date"
    t.decimal "amount_this_term"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["customer_id"], name: "index_customers_on_customer_id"
  end

  create_table "orders", primary_key: "order_id", id: :string, force: :cascade do |t|
    t.decimal "total"
    t.datetime "ordered_at"
    t.string "external_customer_id"
  end

  create_table "questions", force: :cascade do |t|
    t.string "name"
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "orders", "customers", column: "external_customer_id", primary_key: "customer_id"
end
