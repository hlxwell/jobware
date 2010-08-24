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

ActiveRecord::Schema.define(:version => 20100824092136) do

  create_table "ckeditor_assets", :force => true do |t|
    t.string   "data_file_name",                                 :null => false
    t.string   "data_content_type"
    t.integer  "data_file_size"
    t.integer  "assetable_id"
    t.string   "assetable_type",    :limit => 30
    t.string   "type",              :limit => 25
    t.string   "guid",              :limit => 10
    t.integer  "locale",            :limit => 1,  :default => 0
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ckeditor_assets", ["assetable_type", "assetable_id"], :name => "fk_assetable"
  add_index "ckeditor_assets", ["assetable_type", "type", "assetable_id"], :name => "idx_assetable_type"
  add_index "ckeditor_assets", ["user_id"], :name => "fk_user"

  create_table "companies", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "type"
    t.integer  "size"
    t.string   "province"
    t.string   "city"
    t.string   "address"
    t.string   "homepage"
    t.string   "contact_name"
    t.string   "phone_number"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.string   "location_province"
    t.string   "location_city"
    t.integer  "contract_type"
    t.integer  "category"
    t.integer  "vacancy"
    t.text     "content"
    t.text     "requirement"
    t.text     "welfare"
    t.text     "desc"
    t.string   "salary_range"
    t.datetime "highlight_start_at"
    t.datetime "highlight_end_at"
    t.datetime "start_at"
    t.datetime "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "partners", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "url"
    t.string   "contact_name"
    t.string   "phone_number"
    t.integer  "site_size"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "resumes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.string   "gender"
    t.integer  "working_years"
    t.string   "degree"
    t.string   "major"
    t.date     "birthday"
    t.string   "hometown_province"
    t.string   "hometown_city"
    t.string   "current_residence_province"
    t.string   "current_residence_city"
    t.string   "email"
    t.string   "phone_number"
    t.string   "expected_salary"
    t.string   "expected_positions"
    t.string   "expected_job_location"
    t.integer  "current_working_state"
    t.date     "highlight_start_at"
    t.date     "highlight_end_at"
    t.boolean  "is_sending_sms"
    t.integer  "icon_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", :force => true do |t|
    t.string   "login",                              :null => false
    t.string   "email",                              :null => false
    t.string   "crypted_password",                   :null => false
    t.string   "password_salt",                      :null => false
    t.string   "persistence_token",                  :null => false
    t.string   "single_access_token",                :null => false
    t.integer  "login_count",         :default => 0, :null => false
    t.integer  "failed_login_count",  :default => 0, :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
