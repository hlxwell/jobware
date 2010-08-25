# == Schema Information
# Schema version: 20100825101513
#
# Table name: previous_jobs
#
#  id           :integer(4)      not null, primary key
#  resume_id    :integer(4)
#  company_name :string(255)
#  company_type :integer(4)
#  company_size :integer(4)
#  job_title    :string(255)
#  start_at     :datetime
#  end_at       :datetime
#  created_at   :datetime
#  updated_at   :datetime
#

class PreviousJob < ActiveRecord::Base
  attr_accessible :resume_id, :company_name, :company_type, :company_size, :job_title, :start_at, :end_at
end
