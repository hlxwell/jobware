class CreateResumes < ActiveRecord::Migration
  def self.up
    create_table :resumes do |t|
      t.integer :user_id
      t.string :name
      t.string :gender
      t.integer :working_years
      t.string :degree
      t.string :major
      t.date :birthday
      t.string :hometown_province
      t.string :hometown_city
      t.string :current_residence_province
      t.string :current_residence_city
      t.string :email
      t.string :phone_number
      t.string :expected_salary
      t.string :expected_positions
      t.string :expected_job_location
      t.integer :current_working_state
      t.date :highlight_start_at
      t.date :highlight_end_at
      t.boolean :is_sending_sms
      t.integer :icon_type
      t.timestamps
    end
  end
  
  def self.down
    drop_table :resumes
  end
end
