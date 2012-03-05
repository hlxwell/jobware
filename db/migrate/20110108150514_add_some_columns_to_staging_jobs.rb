# -*- encoding : utf-8 -*-
class AddSomeColumnsToStagingJobs < ActiveRecord::Migration
  def self.up
    add_column :staging_jobs, :company_size, :string
    add_column :staging_jobs, :company_type, :string
    add_column :staging_jobs, :company_homepage, :string
    add_column :staging_jobs, :company_address, :string
    add_column :staging_jobs, :company_phone_number, :string
    add_column :staging_jobs, :company_contact_name, :string
    add_column :staging_jobs, :email, :string
  end

  def self.down
    remove_column :staging_jobs, :company_size
    remove_column :staging_jobs, :company_type
    remove_column :staging_jobs, :company_homepage
    remove_column :staging_jobs, :company_address
    remove_column :staging_jobs, :company_phone_number
    remove_column :staging_jobs, :company_contact_name
    remove_column :staging_jobs, :email
  end
end
