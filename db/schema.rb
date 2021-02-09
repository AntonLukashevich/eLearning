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

ActiveRecord::Schema.define(version: 2021_02_09_074114) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "certificates", force: :cascade do |t|
    t.string "title"
    t.date "date_graduation"
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_certificates_on_course_id"
    t.index ["user_id"], name: "index_certificates_on_user_id"
  end

  create_table "course_authors", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_authors_on_course_id"
    t.index ["user_id"], name: "index_course_authors_on_user_id"
  end

  create_table "course_blocks", force: :cascade do |t|
    t.integer "order"
    t.string "type"
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_course_blocks_on_course_id"
  end

  create_table "courses", force: :cascade do |t|
    t.string "titile"
    t.text "description"
    t.string "status"
    t.string "type_course"
    t.integer "rating"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "image_contents", force: :cascade do |t|
    t.string "image"
    t.bigint "lecture_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecture_block_id"], name: "index_image_contents_on_lecture_block_id"
  end

  create_table "lecture_blocks", force: :cascade do |t|
    t.string "title"
    t.string "type"
    t.integer "order"
    t.bigint "lecture_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecture_id"], name: "index_lecture_blocks_on_lecture_id"
  end

  create_table "lectures", force: :cascade do |t|
    t.string "title"
    t.text "description"
    t.bigint "course_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_block_id"], name: "index_lectures_on_course_block_id"
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "text_contents", force: :cascade do |t|
    t.text "text"
    t.bigint "lecture_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecture_block_id"], name: "index_text_contents_on_lecture_block_id"
  end

  create_table "user_courses_lists", force: :cascade do |t|
    t.float "current_result"
    t.boolean "certificate"
    t.bigint "user_id", null: false
    t.bigint "course_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["course_id"], name: "index_user_courses_lists_on_course_id"
    t.index ["user_id"], name: "index_user_courses_lists_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "first_name"
    t.string "last_name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "role_id", null: false
    t.bigint "organization_id", null: false
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["role_id"], name: "index_users_on_role_id"
  end

  create_table "video_contents", force: :cascade do |t|
    t.string "video"
    t.bigint "lecture_block_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["lecture_block_id"], name: "index_video_contents_on_lecture_block_id"
  end

  add_foreign_key "certificates", "courses"
  add_foreign_key "certificates", "users"
  add_foreign_key "course_authors", "courses"
  add_foreign_key "course_authors", "users"
  add_foreign_key "course_blocks", "courses"
  add_foreign_key "image_contents", "lecture_blocks"
  add_foreign_key "lecture_blocks", "lectures"
  add_foreign_key "lectures", "course_blocks"
  add_foreign_key "text_contents", "lecture_blocks"
  add_foreign_key "user_courses_lists", "courses"
  add_foreign_key "user_courses_lists", "users"
  add_foreign_key "users", "organizations"
  add_foreign_key "users", "roles"
  add_foreign_key "video_contents", "lecture_blocks"
end
