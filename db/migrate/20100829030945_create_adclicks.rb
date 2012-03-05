# -*- encoding : utf-8 -*-
class CreateAdclicks < ActiveRecord::Migration
  def self.up
    create_table :adclicks do |t|
      t.integer :ad_position_id
      t.string :remote_ip
      t.string :source_page
      t.string :dest_page
      t.string :http_user_agent
      t.string :remote_host
      t.string :request_uri

      t.timestamps
    end
  end

  def self.down
    drop_table :adclicks
  end
end
