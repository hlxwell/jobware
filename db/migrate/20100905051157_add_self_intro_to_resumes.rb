class AddSelfIntroToResumes < ActiveRecord::Migration
  def self.up
    add_column :resumes, :self_intro, :text
  end

  def self.down
    remove_column :resumes, :self_intro
  end
end
