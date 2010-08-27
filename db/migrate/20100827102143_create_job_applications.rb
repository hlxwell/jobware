class CreateJobApplications < ActiveRecord::Migration
  def self.up
    create_table :job_applications do |t|
      t.integer :job_id
      t.integer :resume_id
      t.integer :cover_letter_id
      t.string :state
      t.timestamps
    end
  end
  
  def self.down
    drop_table :job_applications
  end
end
