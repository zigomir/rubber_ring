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

ActiveRecord::Schema.define(version: 20130524163156) do

  create_table "rubber_ring_page_contents", force: true do |t|
    t.string   "key"
    t.string   "value"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rubber_ring_page_contents", ["page_id"], name: "index_rubber_ring_page_contents_on_page_id"

  create_table "rubber_ring_page_templates", force: true do |t|
    t.string   "key"
    t.string   "template"
    t.string   "element"
    t.string   "tclass"
    t.integer  "sort"
    t.integer  "page_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "rubber_ring_page_templates", ["page_id"], name: "index_rubber_ring_page_templates_on_page_id"

  create_table "rubber_ring_pages", force: true do |t|
    t.string   "controller"
    t.string   "action"
    t.string   "locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
