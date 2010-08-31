# == Schema Information
# Schema version: 20100831053852
#
# Table name: counters
#
#  id          :integer(4)      not null, primary key
#  click       :integer(4)
#  happend_at  :date
#  parent_type :string(255)
#  parent_id   :integer(4)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class Counter < ActiveRecord::Base
end
