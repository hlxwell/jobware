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
  # attr_accessible :user_id, :name, :gender, :working_years, :degree, :major, :birthday, :hometown_province, :hometown_city, :current_residence_province, :current_residence_city, :email, :phone_number, :expected_salary, :expected_positions, :expected_job_location, :current_working_state, :highlight_start_at, :highlight_end_at, :is_sending_sms, :icon_type
end
