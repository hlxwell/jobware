class AddThemesToJobsAdsCompanies < ActiveRecord::Migration
  def self.up
    add_column :jobs, :themes, :string
    add_column :companies, :themes, :string
    add_column :ads, :themes, :string
  end

  def self.down
    remove_column :ads, :themes
    remove_column :companies, :themes
    remove_column :jobs, :themes
  end
end
