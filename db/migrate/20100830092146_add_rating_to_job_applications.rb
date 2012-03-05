# -*- encoding : utf-8 -*-
class AddRatingToJobApplications < ActiveRecord::Migration
  def self.up
    add_column :job_applications, :rating, :integer
  end

  def self.down
    remove_column :job_applications, :rating
  end
end
