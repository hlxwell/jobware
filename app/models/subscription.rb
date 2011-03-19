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
  has_enumeration_for :period_type, :with => PeriodType

  belongs_to :resume
  validates_presence_of :keywords, :period_type

  def send_newsletter
    return false if last_sent_at.present? and period_type.days.ago < last_sent_at

    last_sent_at = 1.month.ago if last_sent_at.blank?
    jobs = Job.search(keywords, :with => {:updated_at => last_sent_at..Time.now})
    JobseekerMailer.newsletter(user, jobs)
    update_attribute :last_sent_at, Time.now
  end
end
