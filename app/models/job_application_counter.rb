# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20101014064036
#
# Table name: counters
#
#  id          :integer(4)      not null, primary key
#  click       :integer(4)      default(0)
#  happened_at :date
#  parent_type :string(255)
#  parent_id   :integer(4)
#  type        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class JobApplicationCounter < Counter
end
