# -*- encoding : utf-8 -*-
class ChangeTransactionNoteSize < ActiveRecord::Migration
  def self.up    
    change_column :transactions, :note, :text, :limit => 1.megabytes + 1
  end

  def self.down
    change_column :transactions, :note, :text
  end
end
