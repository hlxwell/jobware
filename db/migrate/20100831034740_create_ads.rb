class CreateAds < ActiveRecord::Migration
  def self.up
    create_table :ads do |t|
      t.integer :company_id
      t.integer :position
      t.integer :type
      t.string :url
      t.string :state
      t.date :start_at
      t.date :end_at

      t.timestamps
    end
  end

  def self.down
    drop_table :ads
  end
end
