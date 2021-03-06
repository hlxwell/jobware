# -*- encoding : utf-8 -*-
class CreateCounters < ActiveRecord::Migration
  def self.up
    create_table :counters do |t|
      t.integer :click, :default => 0
      t.date :happend_at
      t.string :parent_type
      t.integer :parent_id
      t.string :type

      t.timestamps
    end
  end

  def self.down
    drop_table :counters
  end
end
