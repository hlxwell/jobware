class CreateSubscriptions < ActiveRecord::Migration
  def self.up
    create_table :subscriptions do |t|
      t.integer :resume_id
      t.string :keywords
      t.integer :period_type
      t.date :last_sent_at

      t.timestamps
    end
  end

  def self.down
    drop_table :subscriptions
  end
end
