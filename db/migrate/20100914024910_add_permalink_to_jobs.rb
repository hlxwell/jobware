# -*- encoding : utf-8 -*-
class AddPermalinkToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :permalink, :string, :default => nil
  end

  def self.down
    remove_column :jobs, :permalink
  end
end
