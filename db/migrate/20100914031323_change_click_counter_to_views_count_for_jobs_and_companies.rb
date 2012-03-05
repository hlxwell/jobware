# -*- encoding : utf-8 -*-
class ChangeClickCounterToViewsCountForJobsAndCompanies < ActiveRecord::Migration
  def self.up
    rename_column :companies, :click_counter, :views_count
    rename_column :jobs, :click_counter, :views_count
  end

  def self.down
    rename_column :jobs, :views_count, :click_counter
    rename_column :companies, :views_count, :click_counter
  end
end
