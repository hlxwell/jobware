class CreateServices < ActiveRecord::Migration
  def self.up
    create_table :services do |t|
      t.integer :serving_target_type
      t.string :name
      t.text :desc
      t.integer :price

      t.timestamps
    end
  end

  def self.down
    drop_table :services
  end
end
