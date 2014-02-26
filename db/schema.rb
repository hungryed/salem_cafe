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

ActiveRecord::Schema.define(version: 20140225214403) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "contacts", force: true do |t|
    t.string   "first_name",  null: false
    t.string   "last_name",   null: false
    t.string   "email",       null: false
    t.string   "subject",     null: false
    t.text     "description", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "food_categories", force: true do |t|
    t.integer  "section_id",                  null: false
    t.string   "name",                        null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "multiple",    default: false
  end

  create_table "foods", force: true do |t|
    t.string   "name",                             null: false
    t.string   "picture"
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "food_category_id"
    t.decimal  "price",            default: 0.0
    t.integer  "section_id"
    t.boolean  "on_menu",          default: false
  end

  create_table "order_foods", force: true do |t|
    t.integer  "food_id",    null: false
    t.integer  "order_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "orders", force: true do |t|
    t.integer  "user_id",                              null: false
    t.datetime "arrival_time",                         null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "section_id"
    t.string   "status",       default: "not started", null: false
  end

  create_table "sections", force: true do |t|
    t.string   "name",                                        null: false
    t.string   "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.time     "start_time",  default: '2000-01-01 00:00:00', null: false
    t.time     "end_time",    default: '2000-01-01 23:00:00', null: false
  end

  create_table "users", force: true do |t|
    t.string   "first_name",                                  null: false
    t.string   "last_name",                                   null: false
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "role",                   default: "customer"
    t.string   "phone_number"
    t.boolean  "receives_texts",         default: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
