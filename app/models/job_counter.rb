# == Schema Information
# Schema version: 20100916071749
#
# Table name: counters
#
#  id          :integer(4)      not null, primary key
#  click       :integer(4)      default(0)
#  happened_at :date
#  parent_type :string(255)
#  parent_id   :integer(4)
#  created_at  :datetime
#  updated_at  :datetime
#  type        :string(255)
#

class JobCounter < Counter
end
