# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[8.0].define(version: 2025_06_12_225202) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"

  create_table "departments", force: :cascade do |t|
    t.bigint "government_id", null: false
    t.string "slug", null: false
    t.string "official_name", null: false
    t.string "display_name", null: false
    t.integer "priority", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["government_id"], name: "index_departments_on_government_id"
    t.index ["slug"], name: "index_departments_on_slug"
  end

  create_table "governments", force: :cascade do |t|
    t.string "name", null: false
    t.string "slug", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "ministers", force: :cascade do |t|
    t.bigint "government_id", null: false
    t.bigint "department_id", null: false
    t.integer "order_of_precedence", null: false
    t.string "person_short_honorific", null: false
    t.datetime "started_at", precision: nil, null: false
    t.datetime "ended_at", precision: nil
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "title", null: false
    t.string "avatar_url"
    t.string "role", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["department_id"], name: "index_ministers_on_department_id"
    t.index ["government_id"], name: "index_ministers_on_government_id"
  end

  add_foreign_key "departments", "governments"
  add_foreign_key "ministers", "departments"
  add_foreign_key "ministers", "governments"
end
