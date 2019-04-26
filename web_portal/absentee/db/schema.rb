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

ActiveRecord::Schema.define(version: 2019_04_26_162019) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "attendances", force: :cascade do |t|
    t.datetime "date"
    t.boolean "present"
    t.bigint "klass_id"
    t.bigint "student_id"
    t.bigint "section_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["klass_id"], name: "index_attendances_on_klass_id"
    t.index ["section_id"], name: "index_attendances_on_section_id"
    t.index ["student_id"], name: "index_attendances_on_student_id"
  end

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

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "attendances", "klasses"
  add_foreign_key "attendances", "sections"
  add_foreign_key "attendances", "students"
  add_foreign_key "klasses", "schools"
  add_foreign_key "sections", "klasses"
  add_foreign_key "students", "klasses"
  add_foreign_key "students", "sections"
end
