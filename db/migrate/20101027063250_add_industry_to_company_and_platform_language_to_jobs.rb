class AddIndustryToCompanyAndPlatformLanguageToJobs < ActiveRecord::Migration
  def self.up
    add_column :companies, :industry, :integer, :default => 99
  end

  def self.down
    remove_column :companies, :industry
  end
end