# == Schema Information
# Schema version: 20100824092136
#
# Table name: jobs
#
#  id                 :integer(4)      not null, primary key
#  name               :string(255)
#  location_province  :string(255)
#  location_city      :string(255)
#  contract_type      :integer(4)
#  category           :integer(4)
#  vacancy            :integer(4)
#  content            :text
#  requirement        :text
#  welfare            :text
#  desc               :text
#  salary_range       :string(255)
#  highlight_start_at :datetime
#  highlight_end_at   :datetime
#  start_at           :datetime
#  end_at             :datetime
#  created_at         :datetime
#  updated_at         :datetime
#

class Job < ActiveRecord::Base
  attr_accessor :accept_terms
  # attr_accessible :name, :location_province, :location_city, :vacancy, :content, :requirement, :welfare, :salary_range, :highlight_start_at, :highlight_end_at, :start_at, :end_at

  belongs_to :company

  validates_presence_of :name, :type #, :size, :address, :contact_name, :phone_number, :province, :city, :desc

  validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"
end
