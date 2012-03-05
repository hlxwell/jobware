# -*- encoding : utf-8 -*-
class AddIndexForStagingJobs < ActiveRecord::Migration
  def self.up
    add_index :staging_jobs, :page_url
  end

  def self.down
    remove_index :staging_jobs, :page_url
  end
end
