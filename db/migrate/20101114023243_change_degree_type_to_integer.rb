# -*- encoding : utf-8 -*-
class ChangeDegreeTypeToInteger < ActiveRecord::Migration
  def self.up
    change_column :resumes, :degree, :integer
  end

  def self.down
    change_column :resumes, :degree, :string
  end
end
