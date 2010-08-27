class JobApplication < ActiveRecord::Base
  belongs_to :job
  belongs_to :resume
  belongs_to :cover_letter
  
  validates_presence_of :cover_letter_id, :job_id, :resume_id
  validates_uniqueness_of :resume_id, :scope => :job_id, :message => "已经投过简历到该职位。"
end