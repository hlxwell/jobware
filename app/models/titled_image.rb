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

### to reprocess all image.
# TitledImage.all.each do |img|
#   img.file.reprocess!
# end

class TitledImage < ActiveRecord::Base
  belongs_to :parent, :polymorphic => true

  has_attached_file :file, :styles => {
    :thumb => "150x150>",
    :popup_preview => "100x100",
    :preview => "50x50",
    :slideshow => "670x250#",
    :slideshow_small => "520x200#",
    :bottom_ad => "166x50#",
    :featured_job => "310x80#",
    :right_ad => "250x70#"
  }, :default_style => :thumb

  validates_attachment_content_type :file, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.file.size.present? }
  validates_attachment_size :file, :less_than => 1.megabytes, :if => lambda {|obj| obj.file.size.present? }
  validates_presence_of :name
end