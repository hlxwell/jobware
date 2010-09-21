class AddStateToPartners < ActiveRecord::Migration
  def self.up
    add_column :partners, :state, :string
  end

  def self.down
    remove_column :partners, :state
  end
end
