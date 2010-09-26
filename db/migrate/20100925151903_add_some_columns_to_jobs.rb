class AddSomeColumnsToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :degree_requirement, :integer, :default => 0
    add_column :jobs, :working_year_requirement, :integer, :default => 0
  end

  def self.down
    remove_column :jobs, :working_year_requirement
    remove_column :jobs, :degree_requirement
  end
end
