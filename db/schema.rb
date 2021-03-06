# -*- encoding : utf-8 -*-
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

ActiveRecord::Schema.define(:version => 20110305141445) do

  create_table "ad_positions", :force => true do |t|
    t.string   "name"
    t.string   "job_list_tags"
    t.integer  "width"
    t.integer  "height"
    t.integer  "ad_type"
    t.integer  "style"
    t.integer  "partner_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "ad_positions", ["partner_id"], :name => "index_ad_positions_on_partner_id"

  create_table "adclicks", :force => true do |t|
    t.integer  "ad_position_id"
    t.string   "remote_ip"
    t.string   "source_page"
    t.string   "dest_page"
    t.string   "http_user_agent"
    t.string   "remote_host"
    t.string   "request_uri"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "adclicks", ["ad_position_id"], :name => "index_adclicks_on_ad_position_id"

  create_table "admin_users", :force => true do |t|
    t.string   "first_name",       :default => "",    :null => false
    t.string   "last_name",        :default => "",    :null => false
    t.string   "role",                                :null => false
    t.string   "email",                               :null => false
    t.boolean  "status",           :default => false
    t.string   "token",                               :null => false
    t.string   "salt",                                :null => false
    t.string   "crypted_password",                    :null => false
    t.string   "preferences"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ads", :force => true do |t|
    t.integer  "company_id"
    t.integer  "position"
    t.integer  "display_type"
    t.string   "url"
    t.string   "state"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "province"
    t.string   "city"
    t.integer  "period"
    t.string   "name"
    t.string   "desc"
    t.string   "image_file_name"
    t.string   "image_content_type"
    t.integer  "image_file_size"
    t.datetime "image_updated_at"
    t.string   "themes",             :default => ""
  end

  add_index "ads", ["company_id"], :name => "index_ads_on_company_id"

  create_table "bank_accounts", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "bank_accounts", ["user_id"], :name => "index_bank_accounts_on_user_id"

  create_table "certifications", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.datetime "get_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "certifications", ["resume_id"], :name => "index_certifications_on_resume_id"

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
    t.integer  "company_type"
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
    t.string   "logo_file_name"
    t.string   "logo_content_type"
    t.integer  "logo_file_size"
    t.datetime "logo_updated_at"
    t.integer  "views_count",       :default => 0
    t.integer  "partner_id"
    t.string   "permalink"
    t.boolean  "open_contact",      :default => false
    t.string   "themes",            :default => ""
    t.integer  "industry",          :default => 99
    t.boolean  "authorized",        :default => true
  end

  add_index "companies", ["partner_id"], :name => "index_companies_on_partner_id"
  add_index "companies", ["user_id"], :name => "index_companies_on_user_id"

  create_table "counters", :force => true do |t|
    t.integer  "click",       :default => 0
    t.date     "happened_at"
    t.string   "parent_type"
    t.integer  "parent_id"
    t.string   "type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "counters", ["id", "type"], :name => "index_counters_on_id_and_type"
  add_index "counters", ["parent_id", "parent_type"], :name => "index_counters_on_parent_id_and_parent_type"

  create_table "cover_letters", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.text     "content"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "cover_letters", ["resume_id"], :name => "index_cover_letters_on_resume_id"

  create_table "delayed_jobs", :force => true do |t|
    t.integer  "priority",   :default => 0
    t.integer  "attempts",   :default => 0
    t.text     "handler"
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], :name => "delayed_jobs_priority"

  create_table "job_applications", :force => true do |t|
    t.integer  "job_id"
    t.integer  "resume_id"
    t.integer  "cover_letter_id"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "rating"
    t.integer  "partner_id"
    t.text     "mail_message"
  end

  add_index "job_applications", ["cover_letter_id"], :name => "index_job_applications_on_cover_letter_id"
  add_index "job_applications", ["job_id"], :name => "index_job_applications_on_job_id"
  add_index "job_applications", ["partner_id"], :name => "index_job_applications_on_partner_id"
  add_index "job_applications", ["resume_id"], :name => "index_job_applications_on_resume_id"

  create_table "jobs", :force => true do |t|
    t.string   "name"
    t.string   "location_province"
    t.string   "location_city"
    t.integer  "contract_type"
    t.integer  "category"
    t.string   "vacancy"
    t.text     "content"
    t.text     "requirement"
    t.text     "welfare"
    t.text     "desc"
    t.integer  "salary_range"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "company_id"
    t.integer  "views_count",                  :default => 0
    t.text     "apply_method"
    t.boolean  "only_use_custom_apply_method"
    t.string   "state"
    t.string   "permalink"
    t.integer  "partner_id"
    t.string   "source"
    t.boolean  "highlighted",                  :default => false
    t.integer  "degree_requirement",           :default => 0
    t.integer  "working_year_requirement",     :default => 0
    t.integer  "keep_top",                     :default => 0
    t.string   "themes",                       :default => ""
  end

  add_index "jobs", ["company_id"], :name => "index_jobs_on_company_id"
  add_index "jobs", ["partner_id"], :name => "index_jobs_on_partner_id"

  create_table "languages", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["resume_id"], :name => "index_languages_on_resume_id"

  create_table "mail_logs", :force => true do |t|
    t.string   "mail_template_path"
    t.string   "recipient"
    t.string   "sender"
    t.string   "subject"
    t.string   "mime_type"
    t.text     "raw_body"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_schedules", :force => true do |t|
    t.string   "name"
    t.integer  "mail_template_id"
    t.string   "user_group"
    t.integer  "count",            :default => 0
    t.integer  "sent_count",       :default => 0
    t.string   "period"
    t.string   "payload"
    t.datetime "first_send_at"
    t.datetime "last_sent_at"
    t.boolean  "available",        :default => false
    t.string   "default_locale"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_template_files", :force => true do |t|
    t.integer  "mail_template_id"
    t.string   "file"
    t.integer  "size"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "mail_templates", :force => true do |t|
    t.string   "name"
    t.string   "subject"
    t.string   "path"
    t.string   "format",        :default => "html"
    t.string   "locale"
    t.string   "handler",       :default => "liquid"
    t.text     "body"
    t.boolean  "partial",       :default => false
    t.boolean  "for_marketing", :default => false
    t.string   "layout",        :default => "none"
    t.string   "zip_file"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "optional_options", :force => true do |t|
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "type"
    t.string   "name"
    t.string   "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "optional_options", ["id", "type"], :name => "index_optional_options_on_id_and_type"
  add_index "optional_options", ["parent_id", "parent_type"], :name => "index_optional_options_on_parent_id_and_parent_type"

  create_table "partner_site_styles", :force => true do |t|
    t.integer  "partner_id"
    t.string   "subdomain"
    t.string   "title"
    t.text     "header"
    t.text     "footer"
    t.text     "stylesheet"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "header_height"
    t.string   "footer_height"
    t.text     "global_css"
    t.string   "theme"
  end

  add_index "partner_site_styles", ["partner_id"], :name => "index_partner_site_styles_on_partner_id"

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
    t.text     "bank_info"
    t.string   "state"
  end

  add_index "partners", ["user_id"], :name => "index_partners_on_user_id"

  create_table "previous_jobs", :force => true do |t|
    t.integer  "resume_id"
    t.string   "company_name"
    t.integer  "company_type"
    t.integer  "company_size"
    t.string   "job_title"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "previous_jobs", ["resume_id"], :name => "index_previous_jobs_on_resume_id"

  create_table "resumes", :force => true do |t|
    t.integer  "user_id"
    t.string   "name"
    t.integer  "gender"
    t.integer  "working_years"
    t.integer  "degree"
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
    t.string   "portrait_file_name"
    t.string   "portrait_content_type"
    t.integer  "portrait_file_size"
    t.datetime "portrait_updated_at"
    t.text     "self_intro"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
    t.integer  "partner_id"
    t.string   "url"
  end

  add_index "resumes", ["partner_id"], :name => "index_resumes_on_partner_id"
  add_index "resumes", ["user_id"], :name => "index_resumes_on_user_id"

  create_table "revenues", :force => true do |t|
    t.integer  "partner_id"
    t.date     "period_start_at"
    t.date     "period_end_at"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "revenues", ["partner_id"], :name => "index_revenues_on_partner_id"

  create_table "schools", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.string   "major"
    t.date     "start_at"
    t.date     "end_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schools", ["resume_id"], :name => "index_schools_on_resume_id"

  create_table "service_item_amounts", :force => true do |t|
    t.integer  "service_id"
    t.integer  "service_item_id"
    t.integer  "amount"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "service_item_amounts", ["service_id"], :name => "index_service_item_amounts_on_service_id"
  add_index "service_item_amounts", ["service_item_id"], :name => "index_service_item_amounts_on_service_item_id"

  create_table "service_items", :force => true do |t|
    t.string   "name"
    t.text     "desc"
    t.integer  "service_length"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "services", :force => true do |t|
    t.integer  "serving_target_type"
    t.string   "name"
    t.text     "desc"
    t.integer  "price"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "skills", :force => true do |t|
    t.integer  "resume_id"
    t.string   "name"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "skills", ["resume_id"], :name => "index_skills_on_resume_id"

  create_table "staging_jobs", :force => true do |t|
    t.string   "name"
    t.string   "location"
    t.string   "vacancy"
    t.string   "industry"
    t.string   "salary_range"
    t.string   "work_year_requirement"
    t.string   "degree_requirement"
    t.string   "contact"
    t.string   "state"
    t.string   "page_url"
    t.string   "origin_id"
    t.text     "desc"
    t.string   "company_name"
    t.text     "company_desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "company_size"
    t.string   "company_type"
    t.string   "company_homepage"
    t.string   "company_address"
    t.string   "company_phone_number"
    t.string   "company_contact_name"
    t.string   "email"
  end

  add_index "staging_jobs", ["page_url"], :name => "index_staging_jobs_on_page_url"

  create_table "starred_jobs", :force => true do |t|
    t.integer  "resume_id"
    t.integer  "job_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "starred_jobs", ["job_id"], :name => "index_starred_jobs_on_job_id"
  add_index "starred_jobs", ["resume_id"], :name => "index_starred_jobs_on_resume_id"

  create_table "starred_resumes", :force => true do |t|
    t.integer  "company_id"
    t.integer  "resume_id"
    t.integer  "rating"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "starred_resumes", ["company_id"], :name => "index_starred_resumes_on_company_id"
  add_index "starred_resumes", ["resume_id"], :name => "index_starred_resumes_on_resume_id"

  create_table "subscriptions", :force => true do |t|
    t.integer  "resume_id"
    t.string   "keywords"
    t.integer  "period_type"
    t.date     "last_sent_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "subscriptions", ["resume_id"], :name => "index_subscriptions_on_resume_id"

  create_table "taggings", :force => true do |t|
    t.integer  "tag_id"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context"
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id"], :name => "index_taggings_on_tag_id"
  add_index "taggings", ["taggable_id", "taggable_type", "context"], :name => "index_taggings_on_taggable_id_and_taggable_type_and_context"

  create_table "tags", :force => true do |t|
    t.string "name"
  end

  create_table "template_partials", :force => true do |t|
    t.string  "placeholder_name"
    t.integer "mail_template_id"
    t.integer "partial_id"
  end

  create_table "titled_images", :force => true do |t|
    t.string   "type"
    t.integer  "parent_id"
    t.string   "parent_type"
    t.string   "name"
    t.text     "desc"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "file_file_name"
    t.string   "file_content_type"
    t.integer  "file_file_size"
    t.datetime "file_updated_at"
  end

  add_index "titled_images", ["id", "type"], :name => "index_titled_images_on_id_and_type"
  add_index "titled_images", ["parent_id", "parent_type"], :name => "index_titled_images_on_parent_id_and_parent_type"

  create_table "transactions", :force => true do |t|
    t.string   "type"
    t.integer  "user_id"
    t.integer  "service_item_id"
    t.integer  "related_object_id"
    t.string   "related_object_type"
    t.string   "from"
    t.string   "to"
    t.float    "amount"
    t.text     "note",                :limit => 16777215
    t.string   "cancel_reason"
    t.datetime "cancelled_at"
    t.datetime "deleted_at"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "partner_id"
  end

  add_index "transactions", ["id", "type"], :name => "index_transactions_on_id_and_type"
  add_index "transactions", ["partner_id"], :name => "index_transactions_on_partner_id"
  add_index "transactions", ["related_object_type", "related_object_id"], :name => "index_transactions_on_related_object_type_and_related_object_id"
  add_index "transactions", ["service_item_id"], :name => "index_transactions_on_service_item_id"
  add_index "transactions", ["user_id"], :name => "index_transactions_on_bank_account_id"

  create_table "users", :force => true do |t|
    t.string   "email",                                :null => false
    t.string   "crypted_password",                     :null => false
    t.string   "password_salt",                        :null => false
    t.string   "persistence_token",                    :null => false
    t.string   "single_access_token",                  :null => false
    t.integer  "login_count",          :default => 0,  :null => false
    t.integer  "failed_login_count",   :default => 0,  :null => false
    t.datetime "last_request_at"
    t.datetime "current_login_at"
    t.datetime "last_login_at"
    t.string   "current_login_ip"
    t.string   "last_login_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "perishable_token",     :default => "", :null => false
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
  end

  add_index "users", ["perishable_token"], :name => "index_users_on_perishable_token"

  create_table "vouchers", :force => true do |t|
    t.string   "code"
    t.integer  "service_item_id"
    t.integer  "user_id"
    t.integer  "amount"
    t.string   "state"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "vouchers", ["service_item_id"], :name => "index_vouchers_on_service_item_id"
  add_index "vouchers", ["user_id"], :name => "index_vouchers_on_user_id"

end
