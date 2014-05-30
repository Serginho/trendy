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

ActiveRecord::Schema.define(version: 20140528161931) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "categories", force: true do |t|
    t.string "name"
    t.string "description"
  end

  create_table "posts", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.string   "image"
    t.string   "url"
    t.integer  "category_id"
    t.integer  "source_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "posts", ["title"], name: "index_posts_on_title", unique: true, using: :btree

  create_table "shares", force: true do |t|
    t.integer "post_id"
    t.integer "user_id"
    t.integer "site_id"
  end

  add_index "shares", ["post_id", "user_id", "site_id"], name: "index_shares_on_post_id_and_user_id_and_site_id", unique: true, using: :btree

  create_table "sites", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "sources", force: true do |t|
    t.string "name"
    t.string "url"
  end

  create_table "training_posts", force: true do |t|
    t.string  "title"
    t.text    "content"
    t.integer "category_id"
  end

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "password_hash"
    t.string   "password_salt"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["username"], name: "index_users_on_username", unique: true, using: :btree

  add_foreign_key "posts", "categories", name: "posts_category_id_fk"
  add_foreign_key "posts", "sources", name: "posts_source_id_fk"

  add_foreign_key "training_posts", "categories", name: "training_posts_category_id_fk"

end
