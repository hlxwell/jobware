class CreateTableMailTemplate < ActiveRecord::Migration
  def self.up
    create_table :mail_templates do |t|
      t.string :name
      t.string :body
      t.timestamps
    end
  end

  def self.down
    drop_table :mail_templates
  end
end