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

ActiveRecord::Schema.define(version: 20170402170652) do

  create_table "accounts", force: :cascade do |t|
    t.string   "name"
    t.string   "holder"
    t.integer  "bank_id"
    t.integer  "current_credit"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.index ["bank_id"], name: "index_accounts_on_bank_id"
  end

  create_table "banks", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "transfer_types", force: :cascade do |t|
    t.string   "name"
    t.integer  "commission"
    t.integer  "max_per_transfer"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
  end

  create_table "transfers", force: :cascade do |t|
    t.datetime "completed_at"
    t.integer  "status_code"
    t.string   "status_message"
    t.integer  "account_from_id"
    t.integer  "account_to_id"
    t.integer  "quantity"
    t.integer  "commission"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
