# -*- encoding : utf-8 -*-
class CreateCoverLetters < ActiveRecord::Migration
  def self.up
    create_table :cover_letters do |t|
      t.integer :resume_id
      t.string :name
      t.text :content
      t.timestamps
    end
  end

  def self.down
    drop_table :cover_letters
  end
end
