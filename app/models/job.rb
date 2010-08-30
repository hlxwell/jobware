# == Schema Information
# Schema version: 20100825034512
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
#  company_id         :integer(4)
#

class Job < ActiveRecord::Base
  has_enumeration_for :category, :with => JobCategory
  has_enumeration_for :contract_type, :with => ContractType

  belongs_to :company
  has_one :user, :through => :company
  has_many :job_applications

  accepts_nested_attributes_for :company

  validates_presence_of :name, :location_province, :location_city, :contract_type, :category, :vacancy, :content, :requirement

  def location
    self.location_province + self.location_city
  end
  
  def salary_range
    "面议" if read_attribute(:salary_range).blank?
  end
end
