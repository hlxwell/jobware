# -*- encoding : utf-8 -*-
class AddOpenContactToCompanies < ActiveRecord::Migration
  def self.up
    add_column :companies, :open_contact, :boolean, :default => false
  end

  def self.down
    remove_column :companies, :open_contact
  end
end
