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

ActiveRecord::Schema.define(version: 20141126161543) do

  create_table "summits", force: true do |t|
    t.string   "name",                                 null: false
    t.text     "deadline",                             null: false
    t.string   "location_city",                        null: false
    t.string   "location_state"
    t.string   "location_country",                     null: false
    t.string   "language",                             null: false
    t.date     "date_start",                           null: false
    t.date     "date_end",                             null: false
    t.integer  "cost",                                 null: false
    t.string   "currency",                             null: false
    t.text     "fields",                               null: false
    t.boolean  "idea_stage",           default: false, null: false
    t.boolean  "planning_stage",       default: false, null: false
    t.boolean  "implementation_stage", default: false, null: false
    t.boolean  "operating_stage",      default: false, null: false
    t.string   "contact_website"
    t.string   "contact_email"
    t.string   "admin_email",                          null: false
    t.string   "admin_url",                            null: false
    t.text     "description",                          null: false
    t.text     "requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
