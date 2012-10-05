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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20110607070039) do

  create_table "customizations", :force => true do |t|
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "font_title"
    t.string   "img_background"
    t.string   "color_text_card"
    t.string   "color_bground"
    t.string   "color_lines"
    t.string   "color_text_lines"
    t.string   "color_card"
    t.string   "color_button"
    t.string   "color_title"
    t.string   "font_card"
    t.string   "font_lines"
    t.string   "color_field_title"
    t.string   "font_field_title"
    t.boolean  "background_mosaic", :default => false
  end

  create_table "external_links", :force => true do |t|
    t.integer   "user_id"
    t.string    "icon"
    t.string    "url"
    t.boolean   "confidential"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "title"
  end

  add_index "external_links", ["user_id"], :name => "index_external_links_on_user_id"

  create_table "invite_codes", :force => true do |t|
    t.integer   "user_id"
    t.string    "code"
    t.text      "commentary"
    t.integer   "use_counter"
    t.timestamp "created_at"
    t.timestamp "updated_at"
  end

  create_table "online_cv_fields", :force => true do |t|
    t.integer   "user_id"
    t.string    "field_name"
    t.text      "field_content"
    t.boolean   "confidential"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.integer   "displayorder"
  end

  create_table "user_contents", :force => true do |t|
    t.integer  "user_id"
    t.string   "picture"
    t.boolean  "picture_confidential"
    t.string   "phone"
    t.text     "address"
    t.text     "description"
    t.boolean  "description_confidential"
    t.string   "file_cv"
    t.boolean  "file_cv_confidential"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "facebook_token"
    t.text     "linkedin_token"
    t.text     "linkedin_secret"
    t.boolean  "info_confidential"
    t.text     "twitter_token"
    t.text     "twitter_secret"
  end

  add_index "user_contents", ["user_id"], :name => "index_user_contents_on_user_id", :unique => true

  create_table "users", :force => true do |t|
    t.string    "email",                                 :default => "", :null => false
    t.string    "encrypted_password",     :limit => 128, :default => "", :null => false
    t.string    "reset_password_token"
    t.timestamp "reset_password_sent_at"
    t.timestamp "remember_created_at"
    t.integer   "sign_in_count",                         :default => 0
    t.timestamp "current_sign_in_at"
    t.timestamp "last_sign_in_at"
    t.string    "current_sign_in_ip"
    t.string    "last_sign_in_ip"
    t.timestamp "created_at"
    t.timestamp "updated_at"
    t.string    "name"
    t.string    "first_name"
    t.string    "pseudo"
    t.string    "domain"
    t.boolean   "email_confidential"
    t.string    "confirmation_token"
    t.timestamp "confirmed_at"
    t.timestamp "confirmation_sent_at"
  end

  add_index "users", ["email"], :name => "index_users_on_email", :unique => true
  add_index "users", ["reset_password_token"], :name => "index_users_on_reset_password_token", :unique => true

end
