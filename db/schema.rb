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

ActiveRecord::Schema.define(version: 20170514043141) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: :cascade do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_type"
    t.integer  "resource_id"
    t.string   "author_type"
    t.integer  "author_id"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
    t.index ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
    t.index ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree
  end

  create_table "amentities", force: :cascade do |t|
    t.boolean  "internet"
    t.boolean  "air_conditioning"
    t.boolean  "cable_tv"
    t.boolean  "breakfast"
    t.boolean  "parking"
    t.boolean  "elevator"
    t.boolean  "heating"
    t.boolean  "hot_tub"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.integer  "room_id"
    t.index ["room_id"], name: "index_amentities_on_room_id", using: :btree
  end

  create_table "card_transactions", force: :cascade do |t|
    t.integer  "card_id"
    t.string   "action"
    t.integer  "amount"
    t.boolean  "success"
    t.string   "authorization"
    t.string   "message"
    t.text     "params"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.index ["card_id"], name: "index_card_transactions_on_card_id", using: :btree
  end

  create_table "cards", force: :cascade do |t|
    t.integer  "reservation_id"
    t.string   "ip_address"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "card_type"
    t.date     "card_expires_on"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["reservation_id"], name: "index_cards_on_reservation_id", using: :btree
  end

  create_table "contacts", force: :cascade do |t|
    t.string   "name"
    t.string   "email"
    t.string   "phone_number"
    t.text     "message"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "conversations", force: :cascade do |t|
    t.integer  "author_id"
    t.integer  "receiver_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["author_id", "receiver_id"], name: "index_conversations_on_author_id_and_receiver_id", unique: true, using: :btree
    t.index ["author_id"], name: "index_conversations_on_author_id", using: :btree
    t.index ["receiver_id"], name: "index_conversations_on_receiver_id", using: :btree
  end

  create_table "image_rooms", force: :cascade do |t|
    t.integer  "room_id"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.datetime "created_at",         null: false
    t.datetime "updated_at",         null: false
    t.index ["room_id"], name: "index_image_rooms_on_room_id", using: :btree
  end

  create_table "personal_messages", force: :cascade do |t|
    t.text     "body"
    t.integer  "conversation_id"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.index ["conversation_id"], name: "index_personal_messages_on_conversation_id", using: :btree
    t.index ["user_id"], name: "index_personal_messages_on_user_id", using: :btree
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string   "phone_number"
    t.string   "pin"
    t.boolean  "verified",     default: false
    t.integer  "user_id"
    t.datetime "created_at",                   null: false
    t.datetime "updated_at",                   null: false
    t.index ["user_id"], name: "index_phone_numbers_on_user_id", using: :btree
  end

  create_table "reservations", force: :cascade do |t|
    t.date     "checkin_date"
    t.date     "checkout_date"
    t.integer  "number_of_guest"
    t.float    "service_fee"
    t.integer  "user_id"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "room_id"
    t.integer  "status_id"
    t.integer  "total"
    t.index ["room_id"], name: "index_reservations_on_room_id", using: :btree
    t.index ["status_id"], name: "index_reservations_on_status_id", using: :btree
    t.index ["user_id"], name: "index_reservations_on_user_id", using: :btree
  end

  create_table "reviews", force: :cascade do |t|
    t.integer  "room_id"
    t.integer  "user_id"
    t.integer  "rank"
    t.text     "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["room_id"], name: "index_reviews_on_room_id", using: :btree
    t.index ["user_id"], name: "index_reviews_on_user_id", using: :btree
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.string "description"
  end

  create_table "rooms", force: :cascade do |t|
    t.integer  "type_of_room_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "address"
    t.integer  "number_of_guest"
    t.integer  "price"
    t.integer  "accomodates"
    t.integer  "number_of_bed"
    t.string   "description"
    t.string   "house_rules"
    t.float    "longitude"
    t.float    "latitude"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "number_of_room"
    t.index ["type_of_room_id"], name: "index_rooms_on_type_of_room_id", using: :btree
    t.index ["user_id"], name: "index_rooms_on_user_id", using: :btree
  end

  create_table "statuses", force: :cascade do |t|
    t.string   "code"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "type_of_rooms", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "code"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",         null: false
    t.string   "encrypted_password",     default: "",         null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,          null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                                  null: false
    t.datetime "updated_at",                                  null: false
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "name",                   default: "Stranger"
    t.datetime "date_of_birth"
    t.boolean  "gender",                 default: true
    t.string   "provider"
    t.string   "uid"
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.integer  "role_id",                default: 3
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true, using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
    t.index ["role_id"], name: "index_users_on_role_id", using: :btree
  end

  add_foreign_key "amentities", "rooms"
  add_foreign_key "card_transactions", "cards"
  add_foreign_key "cards", "reservations"
  add_foreign_key "image_rooms", "rooms"
  add_foreign_key "personal_messages", "conversations"
  add_foreign_key "personal_messages", "users"
  add_foreign_key "phone_numbers", "users"
  add_foreign_key "reservations", "users"
  add_foreign_key "reviews", "rooms"
  add_foreign_key "reviews", "users"
  add_foreign_key "rooms", "type_of_rooms"
  add_foreign_key "rooms", "users"
  add_foreign_key "users", "roles"
end
