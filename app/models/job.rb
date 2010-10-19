# == Schema Information
# Schema version: 20101014064036
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
#  degree_requirement           :integer(4)      default(0)
#  working_year_requirement     :integer(4)      default(0)
#

class Job < ActiveRecord::Base
  STATE = {
    'unapproved' => "等待审核中",
    'rejected' => "被拒绝",
    'opened' => "展示中",
    'closed' => "未展示"
  }

  acts_as_taggable
  chinese_permalink :name
  acts_as_views_count :delay => 1

  has_enumeration_for :category, :with => JobCategory
  has_enumeration_for :contract_type, :with => ContractType
  has_enumeration_for :salary_range, :with => SalaryRange
  has_enumeration_for :degree_requirement, :with => DegreeRequirement
  has_enumeration_for :working_year_requirement, :with => WorkingYearRequirement

  # default_scope order("keep_top desc, updated_at desc")
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
  has_many :welfare_options, :as => :parent, :dependent => :destroy
  has_many :question_options, :as => :parent, :dependent => :destroy

  accepts_nested_attributes_for :company
  accepts_nested_attributes_for :welfare_options, :question_options, :allow_destroy => true

  validates_presence_of :name, :location_province, :location_city, :contract_type, :category, :vacancy, :content, :requirement
  validate :check_tag

  define_index do
    indexes name, :sortable => true
    indexes location_province
    indexes location_city
    # indexes content
    # indexes requirement
    indexes company(:name), :as => :company_name, :sortable => true
    has company_id, created_at, updated_at
  end

  state_machine :state, :initial => :unapproved do
    before_transition :on => :active do |job|
      job.pay_for_active unless job.available?
    end

    after_transition any => :unapproved do |job|
      AdminNotification.need_check(job).deliver
    end

    after_transition :on => :approve do |job|
      CompanyMailer.job_approval(job.company, job).deliver
    end

    after_transition :on => :close do |job|
      unless job.available?
        puts "found one expired job##{id}"

        ### send mail to company
        CompanyMailer.job_expired(job.company, job).deliver
        ## read means unaccepted or unrejected
        job.job_applications.read.each do |app|
          app.update_attribute(:mail_message, "岗位到期。")
          app.reject
        end
      end
    end

    event :approve do
      transition [:rejected, :unapproved] => :closed
    end
    event :reapprove do
      transition any => :unapproved
    end
    event :reject do
      transition any => :rejected
    end
    event :active do
      transition :closed => :opened, :if => :can_open?
    end
    event :close do
      transition :opened => :closed
    end
  end

  def check_tag
    errors.add :tag_list, '请不要超过5个关键字。' if self.tag_list.count > 5
    self.tag_list.each do |tag|
      errors.add :tag_list, '单个关键字请不要超过20个字。' if tag.size > 20
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
      self.user.pay!(1, :service_item_id => ServiceItem.job_keep_top_credit_id, :to => "置顶岗位##{self.id}") if self.keep_top?
      self.partner.try(:increase_job)  # increase job count for referal partner
    end
  end

  def set_available_time
    self.start_at = Date.today
    self.end_at = 30.days.since.to_date
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
    image = self.company.logo.size.nil? ? "" : "<a href='http://itjob.fm/companies/#{self.company.id}' target='_blank'><img src='#{self.company.logo.url(:host => 'itjob.fm')}'/></a>"
    "#{image}
    <br>
      <h1><a href='http://itjob.fm/jobs/#{self.to_param}' target='_blank'>#{self.name}</a></h1>
      公司：<a href='http://itjob.fm/companies/#{self.company.id}' target='_blank'>#{self.company.name}</a>，
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
    # TODO welfare change to tags
  end

  def meta_description
    # TODO welfare change to tags
    "岗位:#{self.name},公司:#{self.company.name},类别:#{self.category_humanize},岗位需求:#{self.requirement},工作内容:#{self.content},福利待遇:#{self.welfare}"
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
