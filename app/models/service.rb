# == Schema Information
# Schema version: 20100831053852
#
# Table name: services
#
#  id                  :integer(4)      not null, primary key
#  serving_target_type :integer(4)
#  name                :string(255)
#  desc                :text
#  price               :integer(4)
#  created_at          :datetime
#  updated_at          :datetime
#

class Service < ActiveRecord::Base
  has_enumeration_for :serving_target_type, :with => ServingTargetType
  SERVING_TARGET_TYPE = ServingTargetType.to_a

  has_many :service_item_amounts
  has_many :service_items, :through => :service_item_amounts

  validates_presence_of :name, :desc, :price, :serving_target_type
  validates_inclusion_of :serving_target_type, :in => ServingTargetType.list

  scope :for_jobseeker, where(:serving_target_type => ServingTargetType::JOBSEEKER)
  scope :for_company, where(:serving_target_type => ServingTargetType::COMPANY)
end
