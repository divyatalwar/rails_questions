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

ActiveRecord::Schema.define(version: 20131227144115) do

  create_table "events", force: true do |t|
    t.date     "start"
    t.date     "end"
    t.boolean  "publishing_bit", default: false
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "offers", force: true do |t|
    t.decimal  "discount",       precision: 10, scale: 0
    t.boolean  "publishing_bit",                          default: false
    t.integer  "event_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "products", force: true do |t|
    t.integer  "quantity"
    t.boolean  "publishing_bit", default: false
    t.integer  "offer_id"
    t.boolean  "published"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
