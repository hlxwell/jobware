# == Schema Information
# Schema version: 20100921080601
#
# Table name: partners
#
#  id           :integer(4)      not null, primary key
#  user_id      :integer(4)
#  name         :string(255)
#  url          :string(255)
#  contact_name :string(255)
#  phone_number :string(255)
#  site_size    :integer(4)
#  desc         :text
#  created_at   :datetime
#  updated_at   :datetime
#  bank_info    :text
#  state        :string(255)
#

class Partner < ActiveRecord::Base
  has_enumeration_for :site_size, :with => SiteSize

  # has_many :ad_positions
  has_many :jobs
  has_many :job_applications
  has_many :companies, :through => :users
  has_many :jobseekers, :class_name => "Resume", :through => :users
  has_many :users
  belongs_to :user
  has_one :partner_site_style
  # counters
  has_many :company_counters, :as => :parent, :dependent => :destroy
  has_many :job_counters, :as => :parent, :dependent => :destroy
  has_many :job_application_counters, :as => :parent, :dependent => :destroy
  has_many :jobseeker_counters, :as => :parent, :dependent => :destroy
  has_many :income_transactions, :class_name => "PositiveTransaction", :conditions => { :service_item_id => ServiceItem.money_id }, :order => "created_at ASC"

  accepts_nested_attributes_for :user

  validates_presence_of :name, :url, :contact_name, :phone_number, :site_size, :desc

  state_machine :state, :initial => :unapproved do
    after_transition :on => :approve do |partner|
      PartnerMailer.approval(partner).deliver
    end

    after_transition any => :unapproved do |partner|
      AdminNotification.need_check(partner).deliver
    end

    event :approve do
      transition any => :approved
    end

    event :reject do
      transition any => :rejected
    end
  end

  [:job, :job_application, :company, :jobseeker].each do |method_name|
    define_method("increase_#{method_name}") do |*args|
      self.send("#{method_name}_counters".to_sym).create(:happened_at => Date.today) if self.send("#{method_name}_counters".to_sym).today.blank?
      self.send("#{method_name}_counters".to_sym).today.last.increment!(:click)
    end
  end

  def income

  end

  def has_partner_site?
    self.partner_site_style.try(:subdomain).try(:present?)
  end
end