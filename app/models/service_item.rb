# == Schema Information
# Schema version: 20100831035618
#
# Table name: service_items
#
#  id             :integer(4)      not null, primary key
#  type           :string(255)
#  name           :string(255)
#  desc           :text
#  service_length :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class ServiceItem < ActiveRecord::Base
  has_enumeration_for :type, :with => CreditType

  has_many :service_item_amounts
  has_many :service, :through => :service_item_amounts
end