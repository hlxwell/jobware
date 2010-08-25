# == Schema Information
# Schema version: 20100825101513
#
# Table name: titled_images
#
#  id                :integer(4)      not null, primary key
#  type              :string(255)
#  parent_id         :integer(4)
#  parent_type       :string(255)
#  name              :string(255)
#  desc              :text
#  created_at        :datetime
#  updated_at        :datetime
#  file_file_name    :string(255)
#  file_content_type :string(255)
#  file_file_size    :integer(4)
#  file_updated_at   :datetime
#

class TitledImage < ActiveRecord::Base
  belongs_to :imageable, :polymorphic => true

  has_attached_file :file, :styles => { :thumb => "100x100>" }
  validates_attachment_content_type :file, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}]
end