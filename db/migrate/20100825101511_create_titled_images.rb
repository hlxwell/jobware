class CreateTitledImages < ActiveRecord::Migration
  def self.up
    create_table :titled_images do |t|
      t.string :type
      t.references :parent, :polymorphic => true
      t.string :name
      t.text :desc
      t.timestamps
    end
  end

  def self.down
    drop_table :titled_images
  end
end