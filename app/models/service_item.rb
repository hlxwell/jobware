# == Schema Information
# Schema version: 20100901023638
#
# Table name: service_items
#
#  id             :integer(4)      not null, primary key
#  credit_type    :integer(4)
#  name           :string(255)
#  desc           :text
#  service_length :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class ServiceItem < ActiveRecord::Base
  has_enumeration_for :credit_type, :with => CreditType
  CREDIT_TYPE = CreditType.to_a

  validates_inclusion_of :credit_type, :in => CreditType.list
  validates_presence_of :name, :desc, :service_length, :credit_type

  has_many :service_item_amounts
  has_many :service, :through => :service_item_amounts
end
