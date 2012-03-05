# -*- encoding : utf-8 -*-
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
  attr_accessor :not_require_file

  belongs_to :parent, :polymorphic => true

  has_attached_file :file, :styles => {
    :preview => "50>x50",
    :thumb => "150>x150",
    :popup_preview => "100>x100",
    :slideshow_small => "670>x230",
    :slideshow => "960>x500",
  }, :default_style => :thumb

  validates_attachment_content_type :file, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.file.size.present? }
  validates_attachment_size :file, :less_than => 5.megabytes, :message => "文件尺寸不得大于5M。", :if => lambda {|obj| obj.file.size.present? }
  validates_presence_of :name
  validate :check_file

  def check_file
    return if @not_require_file

    if self.file.size.blank?
      errors.add :file, "必须上传logo。"
    else
      errors.add :file, "文件大小不能大于5M。" if self.file.size > 5.megabytes
      errors.add :file, "只允许上传 jpg, gif, png。" if File.extname(self.file.original_filename) !~ /\.(jpe?g)|(gif)|(png)/i
    end
  end
end
