class ChangeAllStartAtAndEndAtToDateType < ActiveRecord::Migration
  def self.up
    change_column :jobs, :start_at, :date
    change_column :jobs, :end_at, :date
    change_column :jobs, :highlight_start_at, :date
    change_column :jobs, :highlight_end_at, :date

    change_column :previous_jobs, :start_at, :date
    change_column :previous_jobs, :end_at, :date

    change_column :schools, :start_at, :date
    change_column :schools, :end_at, :date
  end

  def self.down
    change_column :jobs, :start_at, :datetime
    change_column :jobs, :end_at, :datetime
    change_column :jobs, :highlight_start_at, :datetime
    change_column :jobs, :highlight_end_at, :datetime

    change_column :previous_jobs, :start_at, :datetime
    change_column :previous_jobs, :end_at, :datetime

    change_column :schools, :start_at, :datetime
    change_column :schools, :end_at, :datetime    
  end
end
