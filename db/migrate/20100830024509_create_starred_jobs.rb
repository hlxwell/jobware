# -*- encoding : utf-8 -*-
class CreateStarredJobs < ActiveRecord::Migration
  def self.up
    create_table :starred_jobs do |t|
      t.integer :resume_id
      t.integer :job_id
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :starred_jobs
  end
end
