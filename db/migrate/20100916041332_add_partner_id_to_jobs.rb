# -*- encoding : utf-8 -*-
class AddPartnerIdToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :partner_id, :integer
    add_column :job_applications, :partner_id, :integer
    add_column :companies, :partner_id, :integer
    add_column :resumes, :partner_id, :integer
  end

  def self.down
    remove_column :jobs, :partner_id
    remove_column :job_applications, :partner_id
    remove_column :companies, :partner_id
    remove_column :resumes, :partner_id
  end
end
