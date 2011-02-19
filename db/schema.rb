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

ActiveRecord::Schema.define(:version => 20110219150758) do

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
    t.string   "author_slug"
    t.string   "status"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "countries", :force => true do |t|
    t.string  "iso"
    t.string  "name"
    t.string  "printable_name"
    t.string  "iso3"
    t.integer "numcode"
  end

  create_table "data_files", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_categories", :force => true do |t|
    t.string   "category_name"
    t.string   "status",        :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "job_industries", :force => true do |t|
    t.string   "industry"
    t.string   "status",     :default => "active"
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
    t.string   "photo",              :default => ""
    t.string   "status"
    t.boolean  "completeness"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "photo_file_name"
    t.string   "photo_content_type"
    t.integer  "photo_file_size"
    t.datetime "photo_updated_at"
  end

  create_table "resume_educations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "institution"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "degree"
    t.string   "field_of_study"
    t.string   "gpa"
    t.string   "location"
    t.integer  "weight"
    t.string   "status",         :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_field_works", :force => true do |t|
    t.integer  "resume_id"
    t.text     "field_works"
    t.string   "status",      :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_hidden_fields", :force => true do |t|
    t.integer  "resume_id"
    t.string   "hidden_field"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_keywords", :force => true do |t|
    t.integer  "resume_id"
    t.text     "keywords"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_personal_informations", :force => true do |t|
    t.integer  "resume_id"
    t.string   "full_name"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.integer  "country"
    t.string   "fax_number"
    t.string   "email"
    t.string   "website"
    t.string   "facebook"
    t.string   "twitter"
    t.string   "flickr"
    t.string   "linked_in"
    t.text     "bio"
    t.string   "status",       :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "phone_number"
    t.string   "linkedin"
  end

  create_table "resume_references", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.string   "title"
    t.string   "organization"
    t.string   "department"
    t.string   "address"
    t.string   "city"
    t.string   "state"
    t.string   "postal_code"
    t.string   "country"
    t.string   "phone_number"
    t.string   "fax_number"
    t.string   "email"
    t.string   "website"
    t.text     "details"
    t.integer  "weight"
    t.string   "status",       :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_section_names", :force => true do |t|
    t.integer  "resume_id"
    t.string   "section"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_section_orders", :force => true do |t|
    t.integer  "resume_id"
    t.text     "orders"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_settings", :force => true do |t|
    t.integer  "resume_id"
    t.string   "status",                 :default => "active"
    t.boolean  "hide_personal_info",     :default => false
    t.boolean  "alert_copy",             :default => true
    t.boolean  "email_notification",     :default => true
    t.boolean  "display_personal_photo", :default => true
    t.boolean  "show_last_updated",      :default => true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_skills", :force => true do |t|
    t.integer  "resume_id"
    t.text     "skills"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_themes", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "theme_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resume_work_experiences", :force => true do |t|
    t.integer  "resume_id"
    t.string   "organization_name"
    t.string   "begin_date"
    t.string   "end_date"
    t.string   "title"
    t.text     "details"
    t.integer  "weight"
    t.string   "status",            :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", :force => true do |t|
    t.integer  "user_id"
    t.string   "title"
    t.string   "url"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sessions", :force => true do |t|
    t.string   "session_id", :null => false
    t.text     "data"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sessions", ["session_id"], :name => "index_sessions_on_session_id"
  add_index "sessions", ["updated_at"], :name => "index_sessions_on_updated_at"

  create_table "themes", :force => true do |t|
    t.string   "theme"
    t.string   "slug"
    t.string   "style",      :default => "1 column"
    t.string   "style_slug", :default => "1_column"
    t.string   "status",     :default => "active"
    t.boolean  "default",    :default => false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "thoughts", :force => true do |t|
    t.integer  "user_id"
    t.text     "thought"
    t.string   "status",     :default => "active"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_sessions", :force => true do |t|
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_threads", :force => true do |t|
    t.integer  "user_id"
    t.integer  "target_id"
    t.string   "thread_type", :default => "profile"
    t.text     "content"
    t.string   "status",      :default => "active"
    t.integer  "private",     :default => 0
    t.integer  "reported",    :default => 0
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
