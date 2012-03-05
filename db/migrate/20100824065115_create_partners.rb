# -*- encoding : utf-8 -*-
class CreatePartners < ActiveRecord::Migration
  def self.up
    create_table :partners do |t|
      t.integer :user_id
      t.string :name
      t.string :url
      t.string :contact_name
      t.string :phone_number
      t.integer :site_size
      t.text :desc
      t.timestamps
    end
  end
  
  def self.down
    drop_table :partners
  end
end
