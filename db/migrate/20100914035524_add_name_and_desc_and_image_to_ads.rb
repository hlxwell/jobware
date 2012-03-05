# -*- encoding : utf-8 -*-
class AddNameAndDescAndImageToAds < ActiveRecord::Migration
  def self.up
    add_column :ads, :name, :string
    add_column :ads, :desc, :string

    add_column :ads, :image_file_name, :string
    add_column :ads, :image_content_type, :string
    add_column :ads, :image_file_size, :integer
    add_column :ads, :image_updated_at, :datetime
  end

  def self.down
    remove_column :ads, :name
    remove_column :ads, :desc

    remove_column :ads, :image_file_name
    remove_column :ads, :image_content_type
    remove_column :ads, :image_file_size
    remove_column :ads, :image_updated_at
  end
end
