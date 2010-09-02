# == Schema Information
# Schema version: 20100902074625
#
# Table name: ad_positions
#
#  id            :integer(4)      not null, primary key
#  name          :string(255)
#  job_list_tags :string(255)
#  width         :integer(4)
#  height        :integer(4)
#  ad_type       :integer(4)
#  style         :integer(4)
#  partner_id    :integer(4)
#  created_at    :datetime
#  updated_at    :datetime
#

class AdPosition < ActiveRecord::Base
  has_enumeration_for :ad_type, :with => AdType

  belongs_to :partner
  validates_presence_of :name, :job_list_tags, :width, :height, :ad_type, :style
  validates_inclusion_of :ad_type, :in => AdType.list
end
