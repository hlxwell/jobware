class AddBankInfoToPartners < ActiveRecord::Migration
  def self.up
    add_column :partners, :bank_info, :text
  end

  def self.down
    remove_column :partners, :bank_info
  end
end
