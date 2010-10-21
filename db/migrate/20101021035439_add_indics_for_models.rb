class AddIndicsForModels < ActiveRecord::Migration
  def self.up

    # These indexes were found by searching for AR::Base finds on your application
    # It is strongly recommanded that you will consult a professional DBA about your infrastucture and implemntation before
    # changing your database in that matter.
    # There is a possibility that some of the indexes offered below is not required and can be removed and not added, if you require
    # further assistance with your rails application, database infrastructure or any other problem, visit:
    #
    # http://www.railsmentors.org
    # http://www.railstutor.org
    # http://guides.rubyonrails.org


    add_index :optional_options, [:parent_id, :parent_type]
    add_index :optional_options, [:id, :type]
    add_index :starred_jobs, :resume_id
    add_index :starred_jobs, :job_id
    add_index :transactions, [:id, :type]
    add_index :transactions, :partner_id
    add_index :jobs, :partner_id
    add_index :jobs, :company_id
    add_index :partners, :user_id
    add_index :titled_images, [:id, :type]
    add_index :titled_images, [:parent_id, :parent_type]
    add_index :schools, :resume_id
    add_index :subscriptions, :resume_id
    add_index :counters, [:id, :type]
    add_index :counters, [:parent_id, :parent_type]
    add_index :partner_site_styles, :partner_id
    add_index :revenues, :partner_id
    add_index :skills, :resume_id
    add_index :ads, :company_id
    add_index :ad_positions, :partner_id
    add_index :certifications, :resume_id
    add_index :companies, :user_id
    add_index :companies, :partner_id
    add_index :job_applications, :resume_id
    add_index :job_applications, :job_id
    add_index :job_applications, :partner_id
    add_index :job_applications, :cover_letter_id
    add_index :resumes, :user_id
    add_index :resumes, :partner_id
    add_index :starred_resumes, :resume_id
    add_index :starred_resumes, :company_id
    add_index :adclicks, :ad_position_id
    add_index :cover_letters, :resume_id
    add_index :languages, :resume_id
    add_index :service_item_amounts, :service_item_id
    add_index :service_item_amounts, :service_id
    add_index :vouchers, :user_id
    add_index :vouchers, :service_item_id
    add_index :previous_jobs, :resume_id
  end

  def self.down
    remove_index :optional_options, :column => [:parent_id, :parent_type]
    remove_index :optional_options, :column => [:id, :type]
    remove_index :starred_jobs, :resume_id
    remove_index :starred_jobs, :job_id
    remove_index :transactions, :column => [:id, :type]
    remove_index :transactions, :partner_id
    remove_index :jobs, :partner_id
    remove_index :jobs, :company_id
    remove_index :partners, :user_id
    remove_index :titled_images, :column => [:id, :type]
    remove_index :titled_images, :column => [:parent_id, :parent_type]
    remove_index :schools, :resume_id
    remove_index :subscriptions, :resume_id
    remove_index :counters, :column => [:id, :type]
    remove_index :counters, :column => [:parent_id, :parent_type]
    remove_index :partner_site_styles, :partner_id
    remove_index :revenues, :partner_id
    remove_index :skills, :resume_id
    remove_index :ads, :company_id
    remove_index :ad_positions, :partner_id
    remove_index :certifications, :resume_id
    remove_index :companies, :user_id
    remove_index :companies, :partner_id
    remove_index :job_applications, :resume_id
    remove_index :job_applications, :job_id
    remove_index :job_applications, :partner_id
    remove_index :job_applications, :cover_letter_id
    remove_index :resumes, :user_id
    remove_index :resumes, :partner_id
    remove_index :starred_resumes, :resume_id
    remove_index :starred_resumes, :company_id
    remove_index :adclicks, :ad_position_id
    remove_index :cover_letters, :resume_id
    remove_index :languages, :resume_id
    remove_index :service_item_amounts, :service_item_id
    remove_index :service_item_amounts, :service_id
    remove_index :vouchers, :user_id
    remove_index :vouchers, :service_item_id
    remove_index :previous_jobs, :resume_id
  end
end
