# == Schema Information
# Schema version: 20100831035618
#
# Table name: companies
#
#  id                :integer(4)      not null, primary key
#  user_id           :integer(4)
#  name              :string(255)
#  company_type      :integer(4)
#  size              :integer(4)
#  province          :string(255)
#  city              :string(255)
#  address           :string(255)
#  homepage          :string(255)
#  contact_name      :string(255)
#  phone_number      :string(255)
#  desc              :text
#  created_at        :datetime
#  updated_at        :datetime
#  logo_file_name    :string(255)
#  logo_content_type :string(255)
#  logo_file_size    :integer(4)
#  logo_updated_at   :datetime
#

class Company < ActiveRecord::Base
  attr_accessor :accept_terms

  has_enumeration_for :company_type, :with => CompanyType
  has_enumeration_for :size, :with => CompanySize

  has_many :starred_resumes
  has_many :candidates, :class_name => "Resume", :through => :starred_resumes
  has_many :jobs
  has_many :job_applications, :through => :jobs
  has_many :resumes, :through => :job_applications
  has_many :products, :as => :parent, :dependent => :destroy
  has_many :presentations, :as => :parent, :dependent => :destroy
  belongs_to :user

  accepts_nested_attributes_for :user, :jobs, :products, :presentations

  validates_presence_of :name, :company_type, :size, :address, :contact_name, :phone_number, :province, :city, :desc
  validates_acceptance_of :accept_terms, :accept => "1", :message => "你必需接受服务条款"

  has_attached_file :logo, :styles => { :thumb => "200>x80" }, :default_style => :thumb
  validates_attachment_content_type :logo, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.logo.size.present? }
  validates_attachment_size :logo, :less_than => 1.megabytes
  validates_attachment_presence :logo

  def location
    self.province + self.city
  end
end
