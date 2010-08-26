class ChangeGenderToIntegerForResumes < ActiveRecord::Migration
  def self.up
    change_column :resumes, :gender, :integer
  end

  def self.down
    change_column :resumes, :gender, :string
  end
end
