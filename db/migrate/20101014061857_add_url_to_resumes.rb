class AddUrlToResumes < ActiveRecord::Migration
  def self.up
    add_column :resumes, :url, :string
  end

  def self.down
    remove_column :resumes, :url
  end
end
