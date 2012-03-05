# -*- encoding : utf-8 -*-
class CreateSchools < ActiveRecord::Migration
  def self.up
    create_table :schools do |t|
      t.integer :resume_id
      t.string :name
      t.string :major
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end
  
  def self.down
    drop_table :schools
  end
end
