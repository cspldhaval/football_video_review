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

ActiveRecord::Schema.define(version: 20160913092637) do

  create_table "orders", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "title"
    t.text     "description"
    t.integer  "status",               default: 1
    t.integer  "total_video_duration"
    t.datetime "created_at",                       null: false
    t.datetime "updated_at",                       null: false
  end

  add_index "orders", ["user_id"], name: "index_orders_on_user_id"

  create_table "payments", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "amount"
    t.datetime "date_of_payment"
    t.text     "other_data"
    t.string   "status"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "payments", ["order_id"], name: "index_payments_on_order_id"

  create_table "prices", force: :cascade do |t|
    t.string   "name"
    t.integer  "price"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "reviewer_id"
    t.text     "technical_notes"
    t.text     "tactical_notes"
    t.integer  "review_time"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "reviews", ["order_id"], name: "index_reviews_on_order_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "avatar_file_name"
    t.string   "avatar_content_type"
    t.integer  "avatar_file_size"
    t.datetime "avatar_updated_at"
    t.string   "first_name"
    t.string   "last_name"
    t.date     "date_of_birth"
    t.integer  "gender"
    t.string   "position"
    t.string   "zipcode"
    t.integer  "user_type"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

  create_table "videos", force: :cascade do |t|
    t.integer  "order_id"
    t.integer  "duration"
    t.text     "description"
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
    t.string   "video_url_file_name"
    t.string   "video_url_content_type"
    t.integer  "video_url_file_size"
    t.datetime "video_url_updated_at"
  end

  add_index "videos", ["order_id"], name: "index_videos_on_order_id"

end
