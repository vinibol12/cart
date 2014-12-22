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

ActiveRecord::Schema.define(version: 20141218082608) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"
  enable_extension "adminpack"

  create_table "baskets", force: true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.string   "title"
    t.text     "description"
    t.string   "image_url"
    t.decimal  "price",       precision: 8, scale: 2
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "queue_groceries", force: true do |t|
    t.integer  "product_id"
    t.integer  "basket_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "quantity",   default: 1
  end

  add_index "queue_groceries", ["basket_id"], name: "index_queue_groceries_on_cart_id", using: :btree
  add_index "queue_groceries", ["product_id"], name: "index_queue_groceries_on_product_id", using: :btree

end
