class AddPartnerIdToTransactions < ActiveRecord::Migration
  def self.up
    add_column :transactions, :partner_id, :integer
  end

  def self.down
    remove_column :transactions, :partner_id
  end
end
