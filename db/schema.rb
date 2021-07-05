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

ActiveRecord::Schema.define(version: 2021_07_05_065921) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["confirmation_token"], name: "index_admins_on_confirmation_token", unique: true
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
    t.index ["unlock_token"], name: "index_admins_on_unlock_token", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.index ["slug"], name: "index_categories_on_slug", unique: true
  end

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string "data_file_name", null: false
    t.string "data_content_type"
    t.integer "data_file_size"
    t.string "type", limit: 30
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["type"], name: "index_ckeditor_assets_on_type"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_type", "sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_type_and_sluggable_id"
  end

  create_table "pages", force: :cascade do |t|
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "post_comment_reports", force: :cascade do |t|
    t.bigint "post_comment_id", null: false
    t.integer "user_id"
    t.integer "report_type"
    t.text "report_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_comment_id"], name: "index_post_comment_reports_on_post_comment_id"
  end

  create_table "post_comment_unvotes", force: :cascade do |t|
    t.bigint "post_comment_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_comment_id"], name: "index_post_comment_unvotes_on_post_comment_id"
  end

  create_table "post_comment_votes", force: :cascade do |t|
    t.bigint "post_comment_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_comment_id"], name: "index_post_comment_votes_on_post_comment_id"
  end

  create_table "post_comments", force: :cascade do |t|
    t.string "content"
    t.integer "commentable_id"
    t.string "commentable_type"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
  end

  create_table "post_follows", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_follows_on_post_id"
  end

  create_table "post_images", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.string "image"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_images_on_post_id"
  end

  create_table "post_links", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.string "image"
    t.string "favicon"
    t.string "title"
    t.string "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_links_on_post_id"
  end

  create_table "post_reports", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.integer "report_type"
    t.text "report_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_reports_on_post_id"
  end

  create_table "post_unvotes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_unvotes_on_post_id"
  end

  create_table "post_votes", force: :cascade do |t|
    t.bigint "post_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_post_votes_on_post_id"
  end

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "user_id"
    t.string "image"
    t.string "link"
    t.integer "view_count"
    t.string "slug"
    t.integer "post_shared_id"
    t.integer "share_count", default: 0
    t.index ["slug"], name: "index_posts_on_slug", unique: true
  end

  create_table "topic_follows", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_topic_follows_on_topic_id"
  end

  create_table "topic_reports", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.integer "user_id"
    t.integer "report_type"
    t.text "report_content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["topic_id"], name: "index_topic_reports_on_topic_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.string "avatar"
    t.string "cover_image"
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "slug"
    t.bigint "category_id", null: false
    t.index ["category_id"], name: "index_topics_on_category_id"
    t.index ["slug"], name: "index_topics_on_slug", unique: true
  end

  create_table "topings", force: :cascade do |t|
    t.bigint "topic_id", null: false
    t.bigint "post_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["post_id"], name: "index_topings_on_post_id"
    t.index ["topic_id"], name: "index_topings_on_topic_id"
  end

  create_table "user_follows", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followee_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "user_notifications", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.string "title"
    t.string "content"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "original_url"
    t.integer "trigger_user_id"
    t.boolean "readed", default: false
    t.string "noti_type"
    t.index ["user_id"], name: "index_user_notifications_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string "current_sign_in_ip"
    t.string "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.integer "failed_attempts", default: 0, null: false
    t.string "unlock_token"
    t.datetime "locked_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "avatar"
    t.string "phone"
    t.string "address"
    t.string "sign"
    t.boolean "root", default: false
    t.boolean "admin", default: false
    t.boolean "user", default: true
    t.string "name"
    t.string "education"
    t.string "job"
    t.string "facebook_site"
    t.string "site"
    t.datetime "birth_day"
    t.string "provider"
    t.string "uid"
    t.string "token"
    t.string "company"
    t.string "school"
    t.text "introduce"
    t.string "cover_image"
    t.boolean "noti_when_comment", default: true
    t.boolean "noti_when_message", default: true
    t.boolean "noti_when_tagging", default: true
    t.boolean "noti_when_follow", default: true
    t.boolean "noti_when_vote", default: false
    t.boolean "noti_when_unvote", default: false
    t.boolean "noti_when_report", default: true
    t.boolean "noti_weekly", default: true
    t.string "slug"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["slug"], name: "index_users_on_slug", unique: true
    t.index ["unlock_token"], name: "index_users_on_unlock_token", unique: true
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "post_comment_reports", "post_comments"
  add_foreign_key "post_comment_unvotes", "post_comments"
  add_foreign_key "post_comment_votes", "post_comments"
  add_foreign_key "post_follows", "posts"
  add_foreign_key "post_images", "posts"
  add_foreign_key "post_links", "posts"
  add_foreign_key "post_reports", "posts"
  add_foreign_key "post_unvotes", "posts"
  add_foreign_key "post_votes", "posts"
  add_foreign_key "topic_follows", "topics"
  add_foreign_key "topic_reports", "topics"
  add_foreign_key "topics", "categories"
  add_foreign_key "topings", "posts"
  add_foreign_key "topings", "topics"
  add_foreign_key "user_notifications", "users"
end
