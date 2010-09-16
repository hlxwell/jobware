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
  default_scope order("happened_at ASC")
  scope :today, where(:happened_at => Date.today)

  belongs_to :parent, :polymorphic => true

  validates_presence_of :click
  validates_uniqueness_of :happened_at, :scope => [:parent_type, :parent_id]

  # class << self
  #   def record_for(obj, counter_name = :views_count)
  #     total_num = obj.send(counter_name)
  #     recorded_num = obj.counters.sum(:click)
  #     today_num = total_num - recorded_num
  #     obj.counters.create(:click => today_num, :happened_at => Date.today)
  #   end
  # end
end