# == Schema Information
# Schema version: 20100916071749
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
#  partner_id      :integer(4)
#

class JobApplication < ActiveRecord::Base
  state_machine :state, :initial => :unread do
    after_transition :on => :accept do |app|
      JobseekerMailer.app_been_accepted(app.resume, app).deliver
    end

    after_transition :on => :reject do |app|
      JobseekerMailer.app_been_rejected(app.resume, app).deliver
    end

    after_transition :on => :view do |app|
      JobseekerMailer.app_been_checked(app.resume, app).deliver
    end

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
  belongs_to :partner

  validates_uniqueness_of :resume_id, :scope => :job_id, :message => "已经投过简历到该职位。"
  validates_presence_of :job_id, :resume_id
  validates_presence_of :cover_letter_id, :if => lambda {|obj| obj.cover_letter.blank? }

  accepts_nested_attributes_for :cover_letter, :allow_destroy => true

  scope :read, where(:state => "read")
  scope :unread, where(:state => "unread")
  scope :starred, where("rating > 0")
  scope :accepted, where(:state => :accepted)
  scope :rejected, where(:state => :rejected)

  def created_at_to_s
    created_at.to_s_short_date
  end

  def state_humanize(options)
    options.reverse_merge!(:for => "company")

    if options[:for] == "jobseeker"
      case state
      when "unread"
        "<span>未被阅读</span>"
      when "read"
        "<b>已被阅读</b>"
      when "accepted"
        "<b class='green'>已被接受</b>"
      when "rejected"
        "<b class='red'>已被拒绝</b>"
      end
    else
      case state
      when "unread"
        "<b class='red'>未被阅读</b>"
      when "read"
        "<span>已被阅读</span>"
      when "accepted"
        "<b class='green'>已被接受</b>"
      when "rejected"
        "<b class='gray'>已被拒绝</b>"
      end
    end
  end
end
