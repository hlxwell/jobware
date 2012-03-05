# -*- encoding : utf-8 -*-
class RemovePartnerSiteIdFromJobAppsAndUsers < ActiveRecord::Migration
  def self.up
    remove_column :users, :partner_site_id
    remove_column :job_applications, :partner_site_id
  end

  def self.down
    add_column :users, :partner_site_id, :integer
    add_column :job_applications, :partner_site_id, :integer
  end
end
