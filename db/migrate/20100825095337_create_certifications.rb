class CreateCertifications < ActiveRecord::Migration
  def self.up
    create_table :certifications do |t|
      t.integer :resume_id
      t.string :name
      t.datetime :get_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :certifications
  end
end
