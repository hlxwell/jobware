# -*- encoding : utf-8 -*-
class CreatePreviousJobs < ActiveRecord::Migration
  def self.up
    create_table :previous_jobs do |t|
      t.integer :resume_id
      t.string :company_name
      t.integer :company_type
      t.integer :company_size
      t.string :job_title
      t.date :start_at
      t.date :end_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :previous_jobs
  end
end
