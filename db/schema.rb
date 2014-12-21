# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20141221121913) do

  create_table "accounts", force: :cascade do |t|
    t.string   "account_number", limit: 255
    t.integer  "currency_id"
    t.decimal  "balance"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "currencies", force: :cascade do |t|
    t.string   "shortname",  limit: 255
    t.string   "longname",   limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "payees", force: :cascade do |t|
    t.string   "nickname",       limit: 255
    t.string   "account_holder", limit: 255
    t.string   "account_number", limit: 255
    t.string   "bank_name",      limit: 255
    t.string   "branch_name",    limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "transfers", force: :cascade do |t|
    t.integer  "account_id"
    t.integer  "payee_id"
    t.integer  "currency_id"
    t.decimal  "value"
    t.text     "description"
    t.date     "transfer_date"
    t.boolean  "repeat"
    t.date     "repeat_until"
    t.string   "status",                     limit: 255
    t.datetime "submitted_at"
    t.boolean  "transaction_password_valid"
    t.boolean  "one_time_password_valid"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
