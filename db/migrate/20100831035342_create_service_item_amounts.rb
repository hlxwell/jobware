class CreateServiceItemAmounts < ActiveRecord::Migration
  def self.up
    create_table :service_item_amounts do |t|
      t.integer :service_id
      t.integer :service_item_id
      t.integer :amount

      t.timestamps
    end
  end

  def self.down
    drop_table :service_item_amounts
  end
end
