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
    :preview => "50>x50",
    :thumb => "150>x150",
    :popup_preview => "100>x100",
    :slideshow_small => "670>x230",
    :slideshow => "980>x500",
  }, :default_style => :thumb

  validates_attachment_content_type :file, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.file.size.present? }
  validates_attachment_size :file, :less_than => 5.megabytes, :message => "文件尺寸不得大于5M。", :if => lambda {|obj| obj.file.size.present? }
  validates_presence_of :name
end