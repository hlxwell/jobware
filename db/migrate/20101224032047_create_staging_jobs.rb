# -*- encoding : utf-8 -*-
class CreateStagingJobs < ActiveRecord::Migration
  def self.up
    create_table :staging_jobs do |t|
      t.string :name
      t.string :location
      t.string :vacancy
      t.string :industry
      t.string :salary_range
      t.string :work_year_requirement
      t.string :degree_requirement
      t.string :contact
      t.string :state
      t.string :page_url
      t.string :origin_id
      t.text :desc
      t.string :company_name
      t.text :company_desc

      t.timestamps
    end
  end

  def self.down
    drop_table :staging_jobs
  end
end
