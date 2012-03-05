# -*- encoding : utf-8 -*-
class CreateCompanies < ActiveRecord::Migration
  def self.up
    create_table :companies do |t|
      t.integer :user_id
      t.string :name
      t.string :type
      t.integer :size
      t.string :province
      t.string :city
      t.string :address
      t.string :homepage
      t.string :contact_name
      t.string :phone_number
      t.text :desc
      t.timestamps
    end
  end
  
  def self.down
    drop_table :companies
  end
end
