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

ActiveRecord::Schema.define(version: 20170428085452) do

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id"
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace"
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id"

  create_table "activity_sqhds", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "subdistrict_id", default: 1
  end

  create_table "admin_users", force: :cascade do |t|
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
    t.float    "postage"
    t.integer  "subdistrict_id"
    t.string   "sms_phone"
  end

  add_index "admin_users", ["email"], name: "index_admin_users_on_email", unique: true
  add_index "admin_users", ["reset_password_token"], name: "index_admin_users_on_reset_password_token", unique: true

  create_table "appointments", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "idname"
    t.string   "type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "count"
    t.integer  "state"
    t.integer  "aptable_id"
    t.string   "aptable_type"
    t.integer  "subdistrict_id"
  end

  add_index "appointments", ["aptable_type", "aptable_id"], name: "index_appointments_on_aptable_type_and_aptable_id"
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id"

  create_table "banners", force: :cascade do |t|
    t.string   "title"
    t.integer  "position"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "banner_type"
    t.integer  "type_id"
    t.integer  "subdistrict_id", default: 1
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "product_id"
    t.integer  "user_id"
    t.integer  "count"
    t.float    "amount"
    t.integer  "state"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "order_id"
    t.integer  "subdistrict_id"
    t.string   "product_title"
  end

  add_index "cart_items", ["order_id"], name: "index_cart_items_on_order_id"
  add_index "cart_items", ["product_id"], name: "index_cart_items_on_product_id"
  add_index "cart_items", ["user_id"], name: "index_cart_items_on_user_id"

  create_table "ckeditor_assets", force: :cascade do |t|
    t.string   "data_file_name",               null: false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.string   "data_fingerprint"
    t.string   "type",              limit: 30
    t.integer  "width"
    t.integer  "height"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
  end

  add_index "ckeditor_assets", ["type"], name: "index_ckeditor_assets_on_type"

  create_table "communities", force: :cascade do |t|
    t.string   "name"
    t.integer  "subdistrict_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "communities", ["subdistrict_id"], name: "index_communities_on_subdistrict_id"

  create_table "contacts", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "phone"
    t.string   "community"
    t.string   "address"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "row_order"
    t.string   "area"
    t.string   "street"
    t.string   "province"
    t.string   "city"
  end

  add_index "contacts", ["user_id"], name: "index_contacts_on_user_id"

  create_table "customer_services", force: :cascade do |t|
    t.string   "name"
    t.string   "phone"
    t.integer  "subdistrict_id"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  add_index "customer_services", ["subdistrict_id"], name: "index_customer_services_on_subdistrict_id"

  create_table "examinations", force: :cascade do |t|
    t.integer  "user_info_id"
    t.date     "date"
    t.float    "sbp"
    t.float    "dbp"
    t.float    "pulse"
    t.float    "bo"
    t.float    "fetalheart"
    t.float    "glu"
    t.float    "chol"
    t.float    "ua"
    t.float    "fat"
    t.float    "bmr"
    t.float    "water"
    t.float    "height"
    t.float    "weight"
    t.float    "bmi"
    t.float    "waistline"
    t.float    "hipline"
    t.float    "whr"
    t.float    "bmd_t"
    t.float    "bmd_z"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.string   "type"
  end

  add_index "examinations", ["date"], name: "index_examinations_on_date"
  add_index "examinations", ["user_info_id"], name: "index_examinations_on_user_info_id"

  create_table "home_blocks", force: :cascade do |t|
    t.string   "title"
    t.integer  "ranking"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  create_table "images", force: :cascade do |t|
    t.string   "title"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
    t.integer  "imageable_id"
    t.string   "imageable_type"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.string   "photo_type"
  end

  add_index "images", ["imageable_type", "imageable_id"], name: "index_images_on_imageable_type_and_imageable_id"

  create_table "news", force: :cascade do |t|
    t.integer  "news_sort_id"
    t.string   "title"
    t.text     "content"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  add_index "news", ["news_sort_id"], name: "index_news_on_news_sort_id"

  create_table "news_sorts", force: :cascade do |t|
    t.integer  "rank"
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  create_table "orders", force: :cascade do |t|
    t.string   "seq"
    t.integer  "state"
    t.string   "pay_way"
    t.float    "price"
    t.integer  "contact_id"
    t.integer  "user_id"
    t.datetime "created_at",                      null: false
    t.datetime "updated_at",                      null: false
    t.float    "postage",        default: 0.0
    t.datetime "paid_time"
    t.integer  "subdistrict_id"
    t.string   "order_type",     default: "精品超市"
    t.text     "cart_item_info"
  end

  create_table "ping_requests", force: :cascade do |t|
    t.string   "object_type"
    t.string   "ping_id"
    t.boolean  "complete"
    t.integer  "amount"
    t.string   "subject"
    t.string   "body"
    t.string   "client_ip"
    t.string   "extra"
    t.string   "order_no"
    t.string   "channel"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.integer  "order_id"
    t.string   "metadata"
  end

  create_table "product_banners", force: :cascade do |t|
    t.integer  "product_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_sorts", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  create_table "products", force: :cascade do |t|
    t.string   "title"
    t.float    "price"
    t.datetime "created_at",                  null: false
    t.datetime "updated_at",                  null: false
    t.integer  "count"
    t.text     "detail"
    t.integer  "state"
    t.integer  "product_sort_id"
    t.float    "after_discount"
    t.datetime "expiration_time"
    t.integer  "product_type",    default: 0
    t.integer  "subdistrict_id"
    t.integer  "initial_sales",   default: 0
  end

  create_table "sms_tokens", force: :cascade do |t|
    t.string   "phone"
    t.string   "token"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "sms_tokens", ["phone"], name: "index_sms_tokens_on_phone"

  create_table "sport_monthlies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "count"
    t.integer  "year"
    t.integer  "month"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  add_index "sport_monthlies", ["user_id"], name: "index_sport_monthlies_on_user_id"

  create_table "sport_weeklies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "count"
    t.integer  "year"
    t.integer  "cweek"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  add_index "sport_weeklies", ["user_id"], name: "index_sport_weeklies_on_user_id"

  create_table "sport_yearlies", force: :cascade do |t|
    t.integer  "user_id"
    t.integer  "count"
    t.integer  "year"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.integer  "subdistrict_id"
  end

  add_index "sport_yearlies", ["user_id"], name: "index_sport_yearlies_on_user_id"

  create_table "sports", force: :cascade do |t|
    t.integer  "user_id"
    t.date     "date"
    t.integer  "count"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "platform"
    t.integer  "version"
    t.integer  "subdistrict_id"
  end

  add_index "sports", ["date"], name: "index_sports_on_date"
  add_index "sports", ["user_id"], name: "index_sports_on_user_id"

  create_table "subdistricts", force: :cascade do |t|
    t.string   "province"
    t.string   "city"
    t.string   "subdistrict"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
    t.string   "district"
    t.string   "property_phone"
    t.string   "alarm_phone"
  end

  create_table "user_infos", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "nickname"
    t.string   "identity_card"
    t.integer  "sex"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.date     "birth"
    t.string   "slogan"
    t.string   "pay_password"
    t.string   "name"
    t.string   "nation"
    t.string   "addr"
    t.string   "community"
  end

  add_index "user_infos", ["user_id"], name: "index_user_infos_on_user_id"

  create_table "users", force: :cascade do |t|
    t.string   "email",                             default: "", null: false
    t.string   "encrypted_password",                default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                     default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                                     null: false
    t.datetime "updated_at",                                     null: false
    t.string   "authentication_token",   limit: 30
    t.string   "phone"
    t.integer  "subdistrict_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["phone"], name: "index_users_on_phone", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
