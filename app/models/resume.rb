# == Schema Information
# Schema version: 20100824092136
#
# Table name: resumes
#
#  id                         :integer(4)      not null, primary key
#  user_id                    :integer(4)
#  name                       :string(255)
#  gender                     :string(255)
#  working_years              :integer(4)
#  degree                     :string(255)
#  major                      :string(255)
#  birthday                   :date
#  hometown_province          :string(255)
#  hometown_city              :string(255)
#  current_residence_province :string(255)
#  current_residence_city     :string(255)
#  email                      :string(255)
#  phone_number               :string(255)
#  expected_salary            :string(255)
#  expected_positions         :string(255)
#  expected_job_location      :string(255)
#  current_working_state      :integer(4)
#  highlight_start_at         :date
#  highlight_end_at           :date
#  is_sending_sms             :boolean(1)
#  icon_type                  :integer(4)
#  created_at                 :datetime
#  updated_at                 :datetime
#

class Resume < ActiveRecord::Base
  belongs_to :user
  # has_many :starred_resumes

  has_many :projects, :as => :has_project
  has_many :skills
  has_many :schools
  has_many :previous_jobs
  has_many :languages
  has_many :cover_letters
  has_many :certifications

  # has_many :job_applications
  # has_many :subscriptions
  # has_many :starred_jobs

  has_attached_file :file, :styles => { :thumb => "100x100>" }
  validates_attachment_content_type :file, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}]
end
