# == Schema Information
# Schema version: 20100910083810
#
# Table name: partner_site_styles
#
#  id         :integer(4)      not null, primary key
#  partner_id :integer(4)
#  subdomain  :string(255)
#  header     :text
#  footer     :text
#  stylesheet :text
#  created_at :datetime
#  updated_at :datetime
#

class PartnerSiteStyle < ActiveRecord::Base
  belongs_to :partner

  validates_uniqueness_of :subdomain
  validates_presence_of :header, :footer, :partner_id
end
