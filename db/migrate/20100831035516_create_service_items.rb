# -*- encoding : utf-8 -*-
class CreateServiceItems < ActiveRecord::Migration
  def self.up
    create_table :service_items do |t|
      t.integer :type
      t.string :name
      t.text :desc
      t.integer :service_length

      t.timestamps
    end
  end

  def self.down
    drop_table :service_items
  end
end
