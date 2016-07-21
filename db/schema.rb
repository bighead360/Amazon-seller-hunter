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

ActiveRecord::Schema.define(version: 20160716015106) do

  create_table "books", force: :cascade do |t|
    t.string   "title",         limit: 510
    t.string   "author",        limit: 510
    t.text     "description",   limit: 65535
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.string   "series",        limit: 255
    t.string   "pages",         limit: 255
    t.string   "publisher",     limit: 255
    t.string   "language",      limit: 255
    t.string   "dimensions",    limit: 255
    t.string   "weight",        limit: 255
    t.string   "cover_image",   limit: 255
    t.integer  "hunter_id",     limit: 4
    t.string   "handle",        limit: 255
    t.integer  "proto_book_id", limit: 4
    t.integer  "cover_type",    limit: 4
    t.string   "isbn",          limit: 255
    t.integer  "condition",     limit: 4
    t.string   "offerURL",      limit: 255
    t.string   "tags",          limit: 255
    t.string   "price",         limit: 255
    t.string   "listPrice",     limit: 255
  end

  add_index "books", ["hunter_id"], name: "index_books_on_hunter_id", using: :btree
  add_index "books", ["proto_book_id"], name: "index_books_on_proto_book_id", using: :btree

  create_table "bookshops", force: :cascade do |t|
    t.string   "shopname",   limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "Amazonid",   limit: 255
  end

  create_table "hunters", force: :cascade do |t|
    t.string   "isbn",       limit: 255
    t.integer  "condition",  limit: 4
    t.integer  "status",     limit: 4
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "isbns", force: :cascade do |t|
    t.string   "isbn",        limit: 255
    t.datetime "created_at",              null: false
    t.datetime "updated_at",              null: false
    t.integer  "Bookshop_id", limit: 4
  end

  add_index "isbns", ["Bookshop_id"], name: "index_isbns_on_Bookshop_id", using: :btree
  add_index "isbns", ["isbn"], name: "index_isbns_on_isbn", unique: true, using: :btree

  create_table "proto_books", force: :cascade do |t|
    t.string   "bsin",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "sellers", force: :cascade do |t|
    t.string   "seller_name",   limit: 255
    t.decimal  "price",                     precision: 8,  scale: 2
    t.boolean  "prime"
    t.decimal  "rate",                      precision: 5,  scale: 2
    t.integer  "total_ratings", limit: 4
    t.boolean  "in_stock"
    t.decimal  "shippingfee",               precision: 4,  scale: 2
    t.string   "ship_from",     limit: 255
    t.decimal  "score",                     precision: 10
    t.boolean  "free_shipping"
    t.datetime "created_at",                                         null: false
    t.datetime "updated_at",                                         null: false
    t.integer  "hunter_id",     limit: 4
    t.string   "amazon_id",     limit: 255
    t.string   "seller_url",    limit: 255
  end

  add_index "sellers", ["hunter_id"], name: "index_sellers_on_hunter_id", using: :btree

  add_foreign_key "books", "hunters"
  add_foreign_key "books", "proto_books"
  add_foreign_key "isbns", "Bookshops"
  add_foreign_key "sellers", "hunters"
end
