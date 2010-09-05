class CreateBankAccounts < ActiveRecord::Migration
  def self.up
    create_table :bank_accounts, :force => true do |t|
      t.integer     :user_id
      t.string      "name"
      t.timestamps
    end
    
    add_index :bank_accounts, :user_id
  end

  def self.down
    drop_table :bank_accounts
  end
end