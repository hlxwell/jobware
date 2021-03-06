# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20101027063250
#
# Table name: partner_site_styles
#
#  id            :integer(4)      not null, primary key
#  partner_id    :integer(4)
#  subdomain     :string(255)
#  title         :string(255)
#  header        :text
#  footer        :text
#  stylesheet    :text
#  created_at    :datetime
#  updated_at    :datetime
#  header_height :string(255)
#  footer_height :string(255)
#  global_css    :text
#  theme         :string(255)
#

class PartnerSiteStyle < ActiveRecord::Base
  belongs_to :partner

  validates_uniqueness_of :subdomain
  validates_presence_of :header, :footer, :header_height, :footer_height, :partner_id
  validates_exclusion_of :subdomain, :in => %w( www itjob admin mail help cnc ), :message => "不能使用该子域名。"
end
