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

class Project < TitledImage
end
