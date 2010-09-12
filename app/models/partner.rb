# == Schema Information
# Schema version: 20100902074625
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
#  bank_info    :text
#

class Partner < ActiveRecord::Base
  has_enumeration_for :site_size, :with => SiteSize

  attr_accessor :accept_terms

  has_many :ad_positions
  belongs_to :user
  has_one :partner_site_style
  accepts_nested_attributes_for :user

  validates_presence_of :name, :url, :contact_name, :phone_number, :site_size, :desc
  validates_acceptance_of :accept_terms, :message => "你必需接受服务条款"
end
