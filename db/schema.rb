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

ActiveRecord::Schema.define(version: 20141208023621) do

  create_table "summits", force: true do |t|
    t.string   "name"
    t.text     "deadline"
    t.string   "application_link"
    t.string   "location_city"
    t.string   "location_state"
    t.string   "location_country"
    t.string   "language"
    t.date     "date_start"
    t.date     "date_end"
    t.integer  "cost"
    t.string   "currency"
    t.text     "fields"
    t.boolean  "idea_stage",           default: false, null: false
    t.boolean  "planning_stage",       default: false, null: false
    t.boolean  "implementation_stage", default: false, null: false
    t.boolean  "operating_stage",      default: false, null: false
    t.string   "contact_website"
    t.string   "contact_email"
    t.string   "admin_email"
    t.text     "description"
    t.text     "requirements"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "edit_code"
    t.boolean  "published",            default: false, null: false
  end

end
