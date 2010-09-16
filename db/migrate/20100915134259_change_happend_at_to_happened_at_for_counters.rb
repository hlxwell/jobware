class ChangeHappendAtToHappenedAtForCounters < ActiveRecord::Migration
  def self.up
    change_column_default :counters, :click, 0
    rename_column :counters, :happend_at, :happened_at
    remove_column :counters, :type
  end

  def self.down
    add_column :counters, :type, :string
    change_column_default :counters, :click, 0
    rename_column :counters, :happened_at, :happend_at
  end
end
