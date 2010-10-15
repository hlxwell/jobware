class CreateOptionalOptions < ActiveRecord::Migration
  def self.up
    create_table :optional_options do |t|
      t.references :parent, :polymorphic => true
      t.string :type
      t.string :name
      t.string :desc
      t.timestamps
    end
  end

  def self.down
    drop_table :optional_options
  end
end
