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

ActiveRecord::Schema.define(version: 2019_04_26_141957) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_stat_statements"
  enable_extension "plpgsql"
  enable_extension "uuid-ossp"

  create_table "klasses", force: :cascade do |t|
    t.bigint "school_id"
    t.integer "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["school_id"], name: "index_klasses_on_school_id"
  end

  create_table "schools", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.string "phone_number", limit: 12
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "sections", force: :cascade do |t|
    t.bigint "klass_id"
    t.string "name", limit: 1
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_sections_on_klass_id"
  end

  create_table "students", force: :cascade do |t|
    t.string "name"
    t.integer "roll_number"
    t.bigint "klass_id"
    t.bigint "section_id"
    t.string "primary_contact_number", limit: 12
    t.string "secondary_contact_number", limit: 12
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_students_on_klass_id"
    t.index ["section_id"], name: "index_students_on_section_id"
  end

  add_foreign_key "klasses", "schools"
  add_foreign_key "sections", "klasses"
  add_foreign_key "students", "klasses"
  add_foreign_key "students", "sections"
end
