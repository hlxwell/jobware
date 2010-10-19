class AddKeepTopToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :keep_top, :boolean
  end

  def self.down
    remove_column :jobs, :keep_top
  end
end
