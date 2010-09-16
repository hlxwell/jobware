# == Schema Information
# Schema version: 20100830092146
#
# Table name: job_applications
#
#  id              :integer(4)      not null, primary key
#  job_id          :integer(4)
#  resume_id       :integer(4)
#  cover_letter_id :integer(4)
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#  rating          :integer(4)
#

class JobApplication < ActiveRecord::Base
  state_machine :state, :initial => :unread do
    event :view do
      transition :unread => :read
    end

    event :accept do
      transition :read => :accepted
    end

    event :reject do
      transition :read => :rejected
    end
  end

  belongs_to :job
  has_one :company, :through => :job
  belongs_to :resume
  belongs_to :cover_letter

  validates_uniqueness_of :resume_id, :scope => :job_id, :message => "已经投过简历到该职位。"
  validates_presence_of :job_id, :resume_id
  validates_presence_of :cover_letter_id, :if => lambda {|obj| obj.cover_letter.blank? }

  accepts_nested_attributes_for :cover_letter, :allow_destroy => true

  scope :unread, where(:state => "unread")
  scope :starred, where("rating > 0")
  scope :accepted, where(:state => :accepted)
  scope :rejected, where(:state => :rejected)

  def created_at_to_s
    created_at.to_s_date
  end

  def state_humanize
    case state
    when "unread"
      "未阅读"
    when "read"
      "已阅读"
    when "accepted"
      "接受"
    when "rejected"
      "拒绝"
    end
  end
end
