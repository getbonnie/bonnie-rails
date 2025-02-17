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

ActiveRecord::Schema.define(version: 2019_04_16_151104) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "btree_gist"
  enable_extension "hstore"
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

  create_table "comments", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "pew_id"
    t.bigint "user_id"
    t.bigint "comment_id"
    t.bigint "emotion_id"
    t.integer "status"
    t.integer "duration"
    t.integer "plays_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notify", default: true
    t.index ["emotion_id"], name: "index_comments_on_emotion_id"
    t.index ["pew_id", "status", "created_at"], name: "index_comments_on_pew_id_and_status_and_created_at"
    t.index ["pew_id"], name: "index_comments_on_pew_id"
    t.index ["status"], name: "index_comments_on_status"
    t.index ["user_id"], name: "index_comments_on_user_id"
    t.index ["uuid"], name: "index_comments_on_uuid", unique: true
  end

  create_table "contacts", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "user_id"
    t.string "name"
    t.string "phone_number"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id", "phone_number"], name: "index_contacts_on_user_id_and_phone_number", unique: true
    t.index ["uuid"], name: "index_contacts_on_uuid"
  end

  create_table "devices", force: :cascade do |t|
    t.bigint "user_id"
    t.string "reference", limit: 40
    t.string "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["reference"], name: "index_devices_on_reference", unique: true
    t.index ["user_id"], name: "index_devices_on_user_id"
  end

  create_table "emotions", force: :cascade do |t|
    t.string "name"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "url"
    t.string "emoji"
    t.integer "position"
    t.index ["status"], name: "index_emotions_on_status"
  end

  create_table "flags", force: :cascade do |t|
    t.string "flagable_type"
    t.bigint "flagable_id"
    t.bigint "user_id"
    t.integer "kind"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["flagable_type", "flagable_id"], name: "index_flags_on_flagable_type_and_flagable_id"
    t.index ["status"], name: "index_flags_on_status"
    t.index ["user_id"], name: "index_flags_on_user_id"
  end

  create_table "followers", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "hashtags", force: :cascade do |t|
    t.bigint "pew_id"
    t.string "tag", limit: 40
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "lower_tag"
    t.index ["created_at"], name: "index_hashtags_on_created_at"
    t.index ["tag"], name: "index_hashtags_on_tag"
  end

  create_table "likes", force: :cascade do |t|
    t.string "likable_type"
    t.bigint "likable_id"
    t.integer "how_much", default: 1, null: false
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["likable_type", "likable_id"], name: "index_likes_on_likable_type_and_likable_id"
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "notification_subscriptions", force: :cascade do |t|
    t.bigint "pew_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.uuid "uuid"
    t.index ["user_id", "pew_id"], name: "index_notification_subscriptions_on_user_id_and_pew_id", unique: true
  end

  create_table "notifications", force: :cascade do |t|
    t.integer "kind"
    t.string "notificationable_type"
    t.bigint "notificationable_id"
    t.bigint "user_id"
    t.bigint "from_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "seen", default: false, null: false
    t.boolean "sent", default: false, null: false
    t.boolean "clicked", default: false, null: false
    t.uuid "uuid"
    t.integer "mode"
    t.index ["from_id"], name: "index_notifications_on_from_id"
    t.index ["notificationable_type", "notificationable_id"], name: "notificationable"
    t.index ["user_id"], name: "index_notifications_on_user_id"
  end

  create_table "pews", force: :cascade do |t|
    t.uuid "uuid"
    t.bigint "user_id"
    t.string "inline_hashtags"
    t.bigint "emotion_id"
    t.integer "status"
    t.integer "duration"
    t.integer "comments_count", default: 0, null: false
    t.integer "plays_count", default: 0, null: false
    t.integer "likes_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "notify", default: true
    t.index ["emotion_id"], name: "index_pews_on_emotion_id"
    t.index ["inline_hashtags", "status", "created_at"], name: "index_pews_on_inline_hashtags_and_status_and_created_at"
    t.index ["status"], name: "index_pews_on_status"
    t.index ["user_id"], name: "index_pews_on_user_id"
    t.index ["uuid"], name: "index_pews_on_uuid", unique: true
  end

  create_table "plays", force: :cascade do |t|
    t.string "playable_type"
    t.bigint "playable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["playable_type", "playable_id"], name: "index_plays_on_playable_type_and_playable_id"
    t.index ["user_id"], name: "index_plays_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.uuid "uuid"
    t.string "name"
    t.date "birthdate"
    t.string "city"
    t.decimal "latitude", precision: 10, scale: 8
    t.decimal "longitude", precision: 11, scale: 8
    t.string "phone"
    t.string "ref_firebase"
    t.boolean "notify_comments"
    t.boolean "notify_likes"
    t.boolean "notify_features"
    t.boolean "notify_ads"
    t.datetime "last_connected_at"
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index "lower((name)::text) varchar_pattern_ops", name: "index_users_on_name_unique", unique: true
    t.index ["status"], name: "index_users_on_status"
    t.index ["uuid"], name: "index_users_on_uuid", unique: true
  end

end
