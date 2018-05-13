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

ActiveRecord::Schema.define(version: 2018_05_13_144004) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string "namespace"
    t.text "body"
    t.string "resource_type"
    t.bigint "resource_id"
    t.string "author_type"
    t.bigint "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace"
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "admin_users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admin_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "color"
    t.integer "questions_count", default: 0, null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_categories_on_status"
  end

  create_table "classifications", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_classifications_on_status"
  end

  create_table "comments", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "reaction_id"
    t.bigint "comment_id"
    t.bigint "emotion_id"
    t.bigint "user_id"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "length"
    t.index ["comment_id"], name: "index_comments_on_comment_id"
    t.index ["emotion_id"], name: "index_comments_on_emotion_id"
    t.index ["reaction_id"], name: "index_comments_on_reaction_id"
    t.index ["status"], name: "index_comments_on_status"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["uuid"], name: "index_comments_on_uuid", unique: true
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "user_id"
    t.string "reference"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "emotions", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["status"], name: "index_emotions_on_status"
  end

  create_table "flags", force: :cascade do |t|
    t.string "flagable_type"
    t.bigint "flagable_id"
    t.bigint "user_id"
    t.integer "type"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flagable_type", "flagable_id"], name: "index_flags_on_flagable_type_and_flagable_id"
    t.index ["status"], name: "index_flags_on_status"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "likes", force: :cascade do |t|
    t.string "likable_type"
    t.bigint "likable_id"
    t.integer "how_much", default: 1, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "type"
    t.bigint "user_id"
    t.bigint "user_id_from"
    t.string "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_notifications_on_user_id"
    t.index ["user_id_from"], name: "index_notifications_on_user_id_from"
  end

  create_table "plays", force: :cascade do |t|
    t.string "playable_type"
    t.bigint "playable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playable_type", "playable_id"], name: "index_plays_on_playable_type_and_playable_id"
  end

  create_table "questions", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "topic_id"
    t.string "short"
    t.string "long"
    t.integer "status"
    t.integer "reactions_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "classification_id"
    t.index ["status"], name: "index_questions_on_status"
    t.index ["topic_id"], name: "index_questions_on_topic_id"
    t.index ["uuid"], name: "index_questions_on_uuid", unique: true
  end

  create_table "reactions", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "question_id"
    t.bigint "user_id"
    t.bigint "emotion_id"
    t.integer "comments_count", default: 0, null: false
    t.integer "plays", default: 0, null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "length"
    t.index ["emotion_id"], name: "index_reactions_on_emotion_id"
    t.index ["question_id"], name: "index_reactions_on_question_id"
    t.index ["status"], name: "index_reactions_on_status"
    t.index ["user_id"], name: "index_reactions_on_user_id"
    t.index ["uuid"], name: "index_reactions_on_uuid", unique: true
  end

  create_table "topics", force: :cascade do |t|
    t.uuid "uuid"
    t.integer "questions_count", default: 0, null: false
    t.string "name"
    t.string "content"
    t.integer "status"
    t.string "category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "tag"
    t.datetime "published_at"
    t.index ["category_id"], name: "index_topics_on_category_id"
    t.index ["status"], name: "index_topics_on_status"
    t.index ["uuid"], name: "index_topics_on_uuid", unique: true
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid"
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "phone"
    t.string "ref_firebase"
    t.boolean "notify_comments"
    t.boolean "notify_likes"
    t.boolean "notify_features"
    t.boolean "notify_ads"
    t.datetime "last_connected_at"
    t.date "birthdate"
    t.string "city"
    t.decimal "latitude", precision: 10, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.index ["status"], name: "index_users_on_status"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

  add_foreign_key "comments", "comments"
  add_foreign_key "comments", "emotions"
  add_foreign_key "comments", "reactions"
  add_foreign_key "comments", "users"
  add_foreign_key "devices", "users"
  add_foreign_key "flags", "users"
  add_foreign_key "notifications", "users"
  add_foreign_key "notifications", "users", column: "user_id_from"
  add_foreign_key "questions", "classifications"
  add_foreign_key "questions", "topics"
  add_foreign_key "reactions", "emotions"
  add_foreign_key "reactions", "questions"
  add_foreign_key "reactions", "users"
end
