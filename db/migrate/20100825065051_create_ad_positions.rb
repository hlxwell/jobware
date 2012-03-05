# -*- encoding : utf-8 -*-
class CreateAdPositions < ActiveRecord::Migration
  def self.up
    create_table :ad_positions do |t|
      t.string :name
      t.string :job_list_tags
      t.integer :width
      t.integer :height
      t.integer :type
      t.integer :style
      t.integer :partner_id
      t.timestamps
    end
  end
  
  def self.down
    drop_table :ad_positions
  end
end
