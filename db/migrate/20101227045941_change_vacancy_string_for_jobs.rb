class ChangeVacancyStringForJobs < ActiveRecord::Migration
  def self.up
    change_column :jobs, :vacancy, :string
  end

  def self.down
    change_column :jobs, :vacancy, :integer
  end
end