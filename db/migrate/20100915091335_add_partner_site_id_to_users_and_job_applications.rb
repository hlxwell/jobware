# -*- encoding : utf-8 -*-
class AddPartnerSiteIdToUsersAndJobApplications < ActiveRecord::Migration
  def self.up
    add_column :users, :partner_site_id, :integer
    add_column :job_applications, :partner_site_id, :integer    
  end

  def self.down
    remove_column :users, :partner_site_id
    remove_column :job_applications, :partner_site_id
  end
end
