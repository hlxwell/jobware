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
  has_enumeration_for :gender, :with => Gender
  has_enumeration_for :current_working_state, :with => WorkingState

  belongs_to :user
  # has_many :starred_resumes

  has_many :projects, :as => :parent, :dependent => :destroy
  has_many :skills, :dependent => :destroy
  has_many :schools, :dependent => :destroy
  has_many :previous_jobs, :dependent => :destroy
  has_many :languages, :dependent => :destroy
  has_many :cover_letters, :dependent => :destroy
  has_many :certifications, :dependent => :destroy

  # has_many :job_applications
  # has_many :subscriptions
  # has_many :starred_jobs

  accepts_nested_attributes_for :user
  accepts_nested_attributes_for :languages, :previous_jobs, :schools, :certifications, :cover_letters, :projects, :skills, :allow_destroy => true

  has_attached_file :portrait, :styles => { :thumb => "150x150>" }, :default_style => :thumb
  validates_attachment_content_type :portrait, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.portrait.size.present? }
  validates_attachment_size :portrait, :less_than => 1.megabytes

  validates_presence_of :name, :gender, :working_years, :degree, :major, :birthday, :hometown_province, :hometown_city, :current_residence_province, :current_residence_city, :email, :phone_number, :expected_positions, :expected_job_location, :expected_salary, :current_working_state

  def hometown
    "#{hometown_province} - #{hometown_city}"
  end

  def current_residence
    "#{current_residence_province} - #{current_residence_city}"
  end

  def portrait_path
    if portrait.size
      portrait.url
    elsif gender == Gender::MALE
      "/images/generic_male.gif"
    elsif gender == Gender::FEMALE
      "/images/generic_female.gif"
    end
  end
end