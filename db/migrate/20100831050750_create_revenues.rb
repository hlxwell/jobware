class CreateRevenues < ActiveRecord::Migration
  def self.up
    create_table :revenues do |t|
      t.integer :partner_id
      t.date :period_start_at
      t.date :period_end_at
      t.string :state

      t.timestamps
    end
  end

  def self.down
    drop_table :revenues
  end
end
