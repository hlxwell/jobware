# == Schema Information
# Schema version: 20100917101409
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
#  highlight_start_at           :datetime
#  highlight_end_at             :datetime
#  start_at                     :datetime
#  end_at                       :datetime
#  created_at                   :datetime
#  updated_at                   :datetime
#  company_id                   :integer(4)
#  views_count                  :integer(4)      default(0)
#  apply_method                 :text
#  only_use_custom_apply_method :boolean(1)
#  state                        :string(255)
#  permalink                    :string(255)
#  partner_id                   :integer(4)
#


# 发布的时候，需要填写 “招聘开始时间，周期，是否高亮”， 保存。
# 审核通过的时候，需要检查 state => approved, 但是需要active, 只有当钱足够的时候才能be actived.
# 然后有个 active 按钮，就是表示去扣点数
#
#

class Job < ActiveRecord::Base
  chinese_permalink :name
  acts_as_views_count :delay => 30

  has_enumeration_for :category, :with => JobCategory
  has_enumeration_for :contract_type, :with => ContractType
  has_enumeration_for :salary_range, :with => SalaryRange

  scope :opened, where("? BETWEEN start_at AND end_at AND state=?", Time.now, :approved)
  scope :closed, where("(? NOT BETWEEN start_at AND end_at) OR state!=?", Time.now, :approved)
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
      transition [:disapproved, :unapproved] => :approved
    end

    event :disapprove do
      transition :unapproved => :disapproved
    end

    event :open do
      transition :closed => :approved
    end

    event :close do
      transition :approved => :closed
    end

    event :reapprove do
      transition :disapproved => :reapproving
    end
  end

  def opened?
    return false if start_at.blank? or end_at.blank? or closed?
    (start_at..end_at).include?(Time.now)
  end

  def state_s
    return "高亮展示中" if highlighted? and opened?
    return "展示中" if opened?
    return "重新审核中" if reapproving?
    return "等待审核中" if unapproved?
    return "审核通过" if approved?
    return "审核不通过" if disapproved?
    return "关闭" if closed?
  end

  def font_color
    return "gray" if unapproved? or closed? or reapproving?
    return "green" if approved?
    return "red" if disapproved?
  end

  def highlighted?
    if highlight_start_at and highlight_end_at
      [highlight_start_at..highlight_end_at].include?(Time.now)
    else
      false
    end
  end

  def to_param
    "#{id}-#{permalink}"
  end

  def location
    self.location_province + self.location_city
  end

  def deadline
    (end_at.to_date - Date.today).to_i
  end

  def increased_views_count
    self.counters.create(:happened_at => Date.today) if self.counters.today.blank?
    self.counters.today.last.increment!(:click)

    update_views_count
    views_count_s
  end

  def atom_content
    image = self.company.logo.size.nil? ? "" : "<a href='/companies/#{self.company.id}' target='_blank'><img src='#{self.company.logo.url}'/></a>"
    "
    #{image}
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
      #{self.welfare}
    "
  end

end
