class ChangeCompaniesTypeToCompanyType < ActiveRecord::Migration
  def self.up
    change_column :companies, :type, :integer
    rename_column :companies, :type, :company_type
  end

  def self.down
    rename_column :companies, :company_type, :type
    change_column :companies, :type, :string
  end
end
