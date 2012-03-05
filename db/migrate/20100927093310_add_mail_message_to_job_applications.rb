# -*- encoding : utf-8 -*-
class AddMailMessageToJobApplications < ActiveRecord::Migration
  def self.up
    add_column :job_applications, :mail_message, :text
  end

  def self.down
    remove_column :job_applications, :mail_message
  end
end
