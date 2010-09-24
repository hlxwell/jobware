# == Schema Information
# Schema version: 20100921080601
#
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
#  salary_range                 :integer(4)
#  start_at                     :date
#  end_at                       :date
#  created_at                   :datetime
#  updated_at                   :datetime
#  company_id                   :integer(4)
#  views_count                  :integer(4)      default(0)
#  apply_method                 :text
#  only_use_custom_apply_method :boolean(1)
#  state                        :string(255)
#  permalink                    :string(255)
#  partner_id                   :integer(4)
#  source                       :string(255)
#  highlighted                  :boolean(1)
#

class Job < ActiveRecord::Base
  STATE = {
    'unapproved' => "等待审核中",
    'rejected' => "被拒绝",
    'opened' => "展示中",
    'closed' => "关闭"
  }

  chinese_permalink :name
  acts_as_views_count :delay => 30

  has_enumeration_for :category, :with => JobCategory
  has_enumeration_for :contract_type, :with => ContractType
  has_enumeration_for :salary_range, :with => SalaryRange

  scope :opened, where("? BETWEEN start_at AND end_at AND state=?", Date.today, :opened)
  scope :closed, where("(? NOT BETWEEN start_at AND end_at) OR state!=?", Date.today, :opened)
  scope :unapproved, where("state = ?", :unapproved)
  scope :approved, where("state in ?", [:closed, :opened])
  scope :highlighted, where(:highlighted => true)

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
    where "#{Date.today} BETWEEN start_at AND end_at AND state='opened'"
  end

  state_machine :state, :initial => :unapproved do
    before_transition :on => :active do |job|
      job.pay_for_active unless job.available?
    end

    after_transition :on => :close do |job|
      unless job.available?
        ### send mail to company
      end
    end

    event :approve do
      transition [:rejected, :unapproved] => :closed
    end

    event :reapprove do
      transition any => :unapproved
    end

    event :reject do
      transition all => :rejected
    end

    event :active do
      transition :closed => :opened, :if => :can_open?
    end

    event :close do
      transition :opened => :closed
    end
  end

  def can_open?
    available? or company_has_enough_credit?
  end

  def company_has_enough_credit?
    return false if self.user.remains(ServiceItem.job_credit_id) <= 0
    return false if self.highlighted? and self.user.remains(ServiceItem.job_highlight_credit_id) <= 0
    return true
  end

  def pay_for_active
    Job.transaction do
      self.set_available_time
      self.user.pay!(1, :service_item_id => ServiceItem.job_credit_id, :to => "激活岗位##{self.id}")
      self.user.pay!(1, :service_item_id => ServiceItem.job_highlight_credit_id, :to => "高亮显示岗位##{self.id}") if self.highlighted?
      self.partner.try(:increase_job)  # increase job count for referal partner
    end
  end

  def set_available_time
    self.start_at = Date.today
    self.end_at = 1.month.since.to_date
    self.save
  end

  def allow_to_apply?
    available? and opened?
  end

  def available?
    return false if start_at.blank? or end_at.blank?
    if (start_at...end_at).include?(Date.today)
      return true
    else
      self.close if self.opened?
      return false
    end
  end

  def to_param
    "#{id}-#{permalink}"
  end

  def location
    self.location_province + self.location_city
  end

  def deadline
    end_at.present? ? (end_at.to_date - Date.today).to_i : 0
  end

  def increased_views_count
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.increment!(:click)

    update_views_count
    views_count_s
  end

  def atom_content
    image = self.company.logo.size.nil? ? "" : "<a href='/companies/#{self.company.id}' target='_blank'><img src='#{self.company.logo.url}'/></a>"
    "#{image}
    <br>
      <h1><a href='/jobs/#{self.to_param}' target='_blank'>#{self.name}</a></h1>
      公司：<a href='/companies/#{self.company.id}' target='_blank'>#{self.company.name}</a>，
      薪酬：#{self.salary_range_humanize}，  岗位数：#{self.vacancy}，  类别：#{self.category_humanize}
    <br>
      <h3>工作内容：</h3>
      #{self.content}
    <br>
      <h3>岗位需求：</h3>
      #{self.requirement}
    <br>
      <h3>福利待遇：</h3>
      #{self.welfare}"
  end

  ### state to cn string
  # unapproved, approved, rejected, opened, closed
  # highlighted available
  def state_s
    return "审核中" if unapproved?
    return "审核被拒绝" if rejected?
    return "展示中" if opened? and available?
    return "高亮展示中" if highlighted? and opened? and available?
    return "未展示" if closed?
    return "已过期" if !available?
  end

  def state_font_color
    case state_s
    when "已过期"
      "blue"
    when "未展示"
      "gray"
    when "审核中"
      "gray"
    when "展示中","高亮展示中"
      "green"
    when "审核被拒绝"
      "red"
    end
  end

  def only_use_custom_apply_method_to_s
    self.only_use_custom_apply_method? ? "否" : "是"
  end
end
