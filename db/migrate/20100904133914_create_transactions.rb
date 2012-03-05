# -*- encoding : utf-8 -*-
class CreateTransactions < ActiveRecord::Migration
  def self.up
    create_table :transactions, :force => true do |t|
      t.string      "type"
      t.integer     "bank_account_id"
      t.integer     "service_item_id"
      t.references  "related_object",   :polymorphic => true
      t.string      "from"
      t.string      "to"
      t.integer     "amount"
      t.string      "note"
      t.string      "cancel_reason"
      t.datetime    "cancelled_at"
      t.datetime    "deleted_at"
      t.timestamps
    end

    add_index :transactions, :service_item_id
    add_index :transactions, :bank_account_id
    add_index :transactions, [:related_object_type, :related_object_id]
  end

  def self.down
    drop_table :transactions
  end
end
