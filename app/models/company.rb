# == Schema Information
# Schema version: 20100824092136
#
# Table name: companies
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  name         :string(255)
#  type         :string(255)
#  size         :integer(4)
#  province     :string(255)
#  city         :string(255)
#  address      :string(255)
#  homepage     :string(255)
#  contact_name :string(255)
#  phone_number :string(255)
#  desc         :text
#  created_at   :datetime
#  updated_at   :datetime
#

class Company < ActiveRecord::Base
  attr_accessor :accept_terms

  has_many :jobs
  belongs_to :user
  accepts_nested_attributes_for :user

  validates_presence_of :name, :company_type, :size, :address, :contact_name, :phone_number, :province, :city, :desc
  validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"
end
