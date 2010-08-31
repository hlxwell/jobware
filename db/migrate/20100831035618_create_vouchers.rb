class CreateVouchers < ActiveRecord::Migration
  def self.up
    create_table :vouchers do |t|
      t.string :code
      t.integer :service_item_id
      t.integer :user_id
      t.integer :amount
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :vouchers
  end
end
