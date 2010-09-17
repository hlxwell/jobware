class ChangeSalaryRangeTypeForJobs < ActiveRecord::Migration
  def self.up
    change_column :jobs, :salary_range, :integer
  end

  def self.down
    change_column :jobs, :salary_range, :string
  end
end
