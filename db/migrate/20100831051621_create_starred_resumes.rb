class CreateStarredResumes < ActiveRecord::Migration
  def self.up
    create_table :starred_resumes do |t|
      t.integer :company_id
      t.integer :resume_id
      t.integer :rating

      t.timestamps
    end
  end

  def self.down
    drop_table :starred_resumes
  end
end
