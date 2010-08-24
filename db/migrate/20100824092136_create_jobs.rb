class CreateJobs < ActiveRecord::Migration
  def self.up
    create_table :jobs do |t|
      t.string :name
      t.string :location_province
      t.string :location_city
      t.integer :contract_type
      t.integer :category
      t.integer :vacancy
      t.text :content
      t.text :requirement
      t.text :welfare
      t.text :desc
      t.string :salary_range
      t.datetime :highlight_start_at
      t.datetime :highlight_end_at
      t.datetime :start_at
      t.datetime :end_at
      t.timestamps
    end
  end

  def self.down
    drop_table :jobs
  end
end
