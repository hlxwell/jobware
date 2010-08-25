class CreateSkills < ActiveRecord::Migration
  def self.up
    create_table :skills do |t|
      t.integer :resume_id
      t.string :name
      t.string :level
      t.timestamps
    end
  end
  
  def self.down
    drop_table :skills
  end
end
