# -*- encoding : utf-8 -*-
class ChangeTypeToAdTypeForAdPositions < ActiveRecord::Migration
  def self.up
    rename_column :ad_positions, :type, :ad_type
  end

  def self.down
    rename_column :ad_positions, :ad_type, :type
  end
end
