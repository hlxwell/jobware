class AddPeriodToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :period, :integer
  end

  def self.down
    remove_column :ads, :period
  end
end
