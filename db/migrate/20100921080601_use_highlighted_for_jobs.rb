# -*- encoding : utf-8 -*-
class UseHighlightedForJobs < ActiveRecord::Migration
  def self.up
    add_column :jobs, :highlighted, :boolean, :default => false
    remove_column :jobs, :highlight_start_at
    remove_column :jobs, :highlight_end_at
  end

  def self.down
    add_column :jobs, :highlight_end_at, :date
    add_column :jobs, :highlight_start_at, :date
    remove_column :jobs, :highlighted
  end
end
