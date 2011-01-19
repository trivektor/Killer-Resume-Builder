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

ActiveRecord::Schema.define(:version => 20110110023108) do

  create_table "blog_comments", :force => true do |t|
    t.integer  "blog_id"
    t.integer  "user_id"
    t.string   "name"
    t.string   "website"
    t.text     "comment"
    t.boolean  "reported"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_recommendations", :force => true do |t|
    t.integer  "blog_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blog_tags", :force => true do |t|
    t.integer "blog_id"
    t.string  "tag"
  end

  create_table "blogs", :force => true do |t|
    t.string   "title"
    t.string   "slug"
    t.text     "summary"
    t.text     "body"
    t.string   "author"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string "country_code"
    t.string "country_name"
  end

  create_table "job_categories", :force => true do |t|
    t.string   "category_name"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_types", :force => true do |t|
    t.string   "type"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profile_analytics", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "profiles", :force => true do |t|
    t.integer  "user_id"
    t.string   "first_name"
    t.string   "last_name"
    t.string   "city"
    t.string   "state"
    t.integer  "country_id"
    t.string   "postal_code"
    t.integer  "job_category_id"
    t.integer  "job_industry_id"
    t.string   "job_title"
    t.string   "website"
    t.string   "gender"
    t.text     "looking_for"
    t.boolean  "hidden"
    t.string   "status"
    t.boolean  "completeness"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "password"
    t.string   "persistence_token"
    t.string   "crypted_password"
    t.string   "password_salt"
    t.string   "single_access_token"
    t.string   "perishable_token"
    t.integer  "login_count"
    t.integer  "failed_login_count"
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
