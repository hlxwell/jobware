# == Schema Information
# Schema version: 20100831053852
#
# Table name: subscriptions
#
#  id           :integer(4)      not null, primary key
#  resume_id    :integer(4)
#  keywords     :string(255)
#  period_type  :integer(4)
#  last_sent_at :date
#  created_at   :datetime
#  updated_at   :datetime
#

class Subscription < ActiveRecord::Base
  belongs_to :resume
end
