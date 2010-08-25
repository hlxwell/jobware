# == Schema Information
# Schema version: 20100825101513
#
# Table name: ad_positions
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  job_list_tags :string(255)
#  width         :integer(4)
#  height        :integer(4)
#  type          :integer(4)
#  style         :integer(4)
#  partner_id    :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class AdPosition < ActiveRecord::Base
  attr_accessible :name, :job_list_tags, :width, :height, :type, :style, :partner_id
end
