class Job < ActiveRecord::Base
  attr_accessor :accept_terms
  # attr_accessible :name, :location_province, :location_city, :vacancy, :content, :requirement, :welfare, :salary_range, :highlight_start_at, :highlight_end_at, :start_at, :end_at

  belongs_to :company

  validates_presence_of :name, :type #, :size, :address, :contact_name, :phone_number, :province, :city, :desc

  validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"
end
