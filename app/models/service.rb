# == Schema Information
# Schema version: 20100831035618
#
# Table name: services
#
#  id                  :integer(4)      not null, primary key
#  serving_target_type :string(255)
#  name                :string(255)
#  desc                :text
#  price               :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#

class Service < ActiveRecord::Base
  has_enumeration_for :serving_target_type, :with => ServingTargetType
  
  has_many :service_item_amounts
  has_many :service_items, :through => :service_item_amounts
end
