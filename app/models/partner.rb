# == Schema Information
# Schema version: 20100824092136
#
# Table name: partners
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  name         :string(255)
#  url          :string(255)
#  contact_name :string(255)
#  phone_number :string(255)
#  site_size    :integer(4)
#  desc         :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Partner < ActiveRecord::Base
  # attr_accessible :user_id, :name, :url, :contact_name, :phone_number, :site_size, :desc
end
