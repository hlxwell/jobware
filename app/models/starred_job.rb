class StarredJob < ActiveRecord::Base
  validates_presence_of :job_id, :resume_id, :rating
  validates_uniqueness_of :job_id, :scope => :resume_id

  belongs_to :job
  belongs_to :resume
end