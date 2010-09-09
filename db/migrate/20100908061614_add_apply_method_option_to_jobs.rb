class AddApplyMethodOptionToJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :apply_method, :text
    add_column :jobs, :only_use_custom_apply_method, :boolean
  end

  def self.down
    remove_column :jobs, :apply_method
    remove_column :jobs, :only_use_custom_apply_method
  end
end
