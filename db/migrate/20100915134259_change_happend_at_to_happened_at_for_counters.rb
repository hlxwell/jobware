# -*- encoding : utf-8 -*-
class ChangeHappendAtToHappenedAtForCounters < ActiveRecord::Migration
  def self.up
    change_column_default :counters, :click, 0
    rename_column :counters, :happend_at, :happened_at
  end

  def self.down
    change_column_default :counters, :click, 0
    rename_column :counters, :happened_at, :happend_at
  end
end
