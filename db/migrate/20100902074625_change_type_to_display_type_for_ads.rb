class ChangeTypeToDisplayTypeForAds < ActiveRecord::Migration
  def self.up
    rename_column :ads, :type, :display_type
  end

  def self.down
    rename_column :ads, :display_type, :type
  end
end
