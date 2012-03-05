# -*- encoding : utf-8 -*-
class AddKeepTopToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :keep_top, :integer, :default => 0
  end

  def self.down
    remove_column :jobs, :keep_top
  end
end
