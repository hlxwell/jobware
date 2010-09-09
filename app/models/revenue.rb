# == Schema Information
# Schema version: 20100831053852
#
# Table name: revenues
#
#  id              :integer(4)      not null, primary key
#  partner_id      :integer(4)
#  period_start_at :date
#  period_end_at   :date
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Revenue < ActiveRecord::Base
  belongs_to :partner  
end
