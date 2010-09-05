class RemoveCreditTypeFromServiceItems < ActiveRecord::Migration
  def self.up
    remove_column :service_items, :credit_type
  end

  def self.down
    add_column :service_items, :credit_type, :integer
  end
end
