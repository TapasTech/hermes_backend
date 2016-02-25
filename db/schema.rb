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

ActiveRecord::Schema.define(version: 20160225120650) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "businesses", force: :cascade do |t|
    t.string   "name"
    t.integer  "parent_business_id"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.datetime "deleted_at"
  end

  add_index "businesses", ["deleted_at"], name: "index_businesses_on_deleted_at", using: :btree
  add_index "businesses", ["name"], name: "index_businesses_on_name", using: :btree
  add_index "businesses", ["parent_business_id"], name: "index_businesses_on_parent_business_id", using: :btree

  create_table "followments", force: :cascade do |t|
    t.integer  "follower_id"
    t.integer  "followee_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "followments", ["followee_id"], name: "index_followments_on_followee_id", using: :btree
  add_index "followments", ["follower_id"], name: "index_followments_on_follower_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email"
    t.string   "password_digest"
    t.string   "display_name"
    t.string   "gender"
    t.integer  "business_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["business_id"], name: "index_users_on_business_id", using: :btree

  add_foreign_key "businesses", "businesses", column: "parent_business_id"
  add_foreign_key "followments", "users", column: "followee_id"
  add_foreign_key "followments", "users", column: "follower_id"
  add_foreign_key "users", "businesses"
end
