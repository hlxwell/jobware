class AddClickCounterToJobsAndCompanies < ActiveRecord::Migration
  def self.up
    add_column :jobs, :click_counter, :integer, :default => 0
    add_column :companies, :click_counter, :integer, :default => 0
  end

  def self.down
    remove_column :companies, :click_counter
    remove_column :jobs, :click_counter
  end
end
