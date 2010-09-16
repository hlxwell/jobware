# == Schema Information
# Schema version: 20100910083810
#`
# Table name: jobs
#
#  id                           :integer(4)      not null, primary key
#  name                         :string(255)
#  location_province            :string(255)
#  location_city                :string(255)
#  contract_type                :integer(4)
#  category                     :integer(4)
#  vacancy                      :integer(4)
#  content                      :text
#  requirement                  :text
#  welfare                      :text
#  desc                         :text
#  salary_range                 :string(255)
#  highlight_start_at           :datetime
#  highlight_end_at             :datetime
#  start_at                     :datetime
#  end_at                       :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#  company_id                   :integer(4)
#  click_counter                :integer(4)      default(0)
#  apply_method                 :text
#  only_use_custom_apply_method :boolean(1)
#  state                        :string(255)
#

class Job < ActiveRecord::Base
  chinese_permalink :name
  acts_as_views_count :delay => 30

  has_enumeration_for :category, :with => JobCategory
  has_enumeration_for :contract_type, :with => ContractType

  scope :opened, where("? BETWEEN start_at AND end_at", Time.now)
  scope :closed, where("? NOT BETWEEN start_at AND end_at", Time.now)
  scope :unapproved, where("state = ?", :unapproved)
  scope :approved, where("state = ?", :approved)
  scope :highlighted, where("? BETWEEN highlight_start_at AND highlight_end_at", Time.now)

  belongs_to :company
  belongs_to :partner
  has_one :user, :through => :company
  has_many :job_applications
  has_many :counters, :as => :parent, :dependent => :destroy, :order => "happened_at ASC"

  accepts_nested_attributes_for :company

  validates_presence_of :name, :location_province, :location_city, :contract_type, :category, :vacancy, :content, :requirement

  define_index do
    indexes name, :sortable => true
    indexes location_province
    indexes location_city
    indexes content
    indexes requirement
    indexes company(:name), :as => :company_name, :sortable => true
    has company_id, created_at, updated_at
  end

  state_machine :state, :initial => :unapproved do
    after_transition any => :approved do |job|
      job.start_at = Time.now
      job.end_at = 1.month.since
      job.save
    end

    event :approve do
      transition :unapproved => :approved
    end
  end

  def to_param
    "#{id}-#{permalink}"
  end

  def location
    self.location_province + self.location_city
  end

  def salary_range
    return "面议" if read_attribute(:salary_range).blank?
    read_attribute(:salary_range)
  end

  def increased_views_count
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.increment!(:click)

    update_views_count
    views_count_s
  end
end
