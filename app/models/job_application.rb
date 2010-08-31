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
  state_machine :initial => :new do
    event :read do
      transition :new => :read
    end
  end

  belongs_to :job
  has_one :company, :through => :job
  belongs_to :resume
  belongs_to :cover_letter

  validates_presence_of :cover_letter_id, :job_id, :resume_id
  validates_uniqueness_of :resume_id, :scope => :job_id, :message => "已经投过简历到该职位。"

  scope :unread, where(:state => "new")
  scope :starred, where("rating > 0")
end
