class Company < ActiveRecord::Base
  attr_accessor :accept_terms
  # attr_accessible :user_id, :name, :type, :size, :province, :city, :address, :homepage, :contact_name, :phone_number, :desc, :accept_terms

  belongs_to :user
  accepts_nested_attributes_for :user

  validates_presence_of :name, :address, :contact_name, :phone_number, :province, :city
  validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"
end