# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20100831035618
#
# Table name: service_item_amounts
#
#  id              :integer(4)      not null, primary key
#  service_id      :integer(4)
#  service_item_id :integer(4)
#  amount          :integer(4)
#  created_at      :datetime
#  updated_at      :datetime
#

class ServiceItemAmount < ActiveRecord::Base
  belongs_to :service
  belongs_to :service_item
end
