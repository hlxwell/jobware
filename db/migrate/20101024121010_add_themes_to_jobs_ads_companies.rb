class AddThemesToJobsAdsCompanies < ActiveRecord::Migration
  def self.up
    add_column :jobs, :themes, :string, :default => ""
    add_column :companies, :themes, :string, :default => ""
    add_column :ads, :themes, :string, :default => ""
  end

  def self.down
    remove_column :ads, :themes
    remove_column :companies, :themes
    remove_column :jobs, :themes
  end
end
