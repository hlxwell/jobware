class ChangeServiceItemsColumns < ActiveRecord::Migration
  def self.up
    rename_column :service_items, :type, :credit_type
  end

  def self.down
    rename_column :service_items, :credit_type, :type
  end
end
