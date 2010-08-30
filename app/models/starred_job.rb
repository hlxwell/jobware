# == Schema Information
# Schema version: 20100830092146
#
# Table name: starred_jobs
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  job_id     :integer(4)
#  rating     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class StarredJob < ActiveRecord::Base
  validates_presence_of :job_id, :resume_id, :rating
  validates_uniqueness_of :job_id, :scope => :resume_id

  belongs_to :job
  belongs_to :resume
end
