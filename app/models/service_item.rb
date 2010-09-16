# == Schema Information
# Schema version: 20100901023638
#
# Table name: service_items
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  desc           :text
#  service_length :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class ServiceItem < ActiveRecord::Base
  validates_presence_of :name, :desc, :service_length
  validates_uniqueness_of :name

  has_many :service_item_amounts
  has_many :service, :through => :service_item_amounts

  def self.money_id
    ServiceItem.find_by_name("人民币").try(:id)
  end
  
  def is_money?
    ServiceItem.money_id == self.id
  end
  
  def self.get_id_by_name(name)
    ServiceItem.find_by_name(name).try(:id)
  end
end