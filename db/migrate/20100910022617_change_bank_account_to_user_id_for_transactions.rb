# -*- encoding : utf-8 -*-
class ChangeBankAccountToUserIdForTransactions < ActiveRecord::Migration
  def self.up
    rename_column :transactions, :bank_account_id, :user_id
  end

  def self.down
    rename_column :transactions, :user_id, :bank_account_id
  end
end
