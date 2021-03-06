# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20100921080601
#
# Table name: previous_jobs
#
#  id           :integer(4)      not null, primary key
#  resume_id    :integer(4)
#  company_name :string(255)
#  company_type :integer(4)
#  company_size :integer(4)
#  job_title    :string(255)
#  start_at     :date
#  end_at       :date
#  created_at   :datetime
#  updated_at   :datetime
#

class PreviousJob < ActiveRecord::Base
  has_enumeration_for :company_type, :with => CompanyType
  has_enumeration_for :company_size, :with => CompanySize

  belongs_to :resume
  validates_presence_of :company_name, :company_type, :company_size, :job_title, :start_at

  def start_at
    read_attribute(:start_at).to_date if read_attribute(:start_at)
  end
  
  def end_at
    read_attribute(:end_at).to_date if read_attribute(:end_at)
  end
end
