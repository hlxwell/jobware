# -*- encoding : utf-8 -*-
class AddAuthorizedToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :authorized, :boolean, :default => true
  end

  def self.down
    remove_column :companies, :authorized
  end
end
