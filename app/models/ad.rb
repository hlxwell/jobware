# == Schema Information
# Schema version: 20100916071749
#
# Table name: ads
#
#  id                 :integer(4)      not null, primary key
#  company_id         :integer(4)
#  position           :integer(4)
#  display_type       :integer(4)
#  url                :string(255)
#  state              :string(255)
#  start_at           :date
#  end_at             :date
#  created_at         :datetime
#  updated_at         :datetime
#  province           :string(255)
#  city               :string(255)
#  period             :integer(4)
#  name               :string(255)
#  desc               :string(255)
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer(4)
#  image_updated_at   :datetime
#

class Ad < ActiveRecord::Base
  default_scope order("position desc, created_at desc")

  DISPLAY_TYPE = AdPositionType.enumeration.values.insert(0, nil).inject do |result, array|
    result ||= {}
    result[array.first] = array.last
    result
  end

  DISPLAY_TYPE_KEYS = {}
  AdPositionType.enumeration.to_a.map { |array| DISPLAY_TYPE_KEYS[array[1][0]] = array[0].to_s }

  STATE = {
    'closed' => "过期",
    'opened' => "展示中",
    'rejected' => "被拒绝",
    'unapproved' => "未支付",
    'approving' => "等待审核中"
  }

  has_enumeration_for :display_type, :with => AdPositionType

  belongs_to :company
  has_one :user, :through => :company

  has_attached_file :image, :styles => {
    :slideshow => "510x250#",
    :slideshow_small => "510x250#",
    :bottom_ad => "180>x50",
    :right_ad => "250>x70"
  }, :default_style => :bottom_ad

  scope :slider_ads, where(:display_type => AdPositionType::SLIDER_AD)
  scope :urgent_jobs, where(:display_type => AdPositionType::URGENT_JOB)
  scope :famous_companies, where(:display_type => AdPositionType::FAMOUS_COMPANY)
  scope :featured_companies, where(:display_type => AdPositionType::FEATURED_COMPANY)
  scope :opened, where("? BETWEEN start_at AND end_at AND state=?", Date.today, :opened)

  state_machine :initial => :unapproved do
    after_transition :on => :want_to_show do |ad|
      ad.pay_for_active
    end

    after_transition :on => :approve do |ad|
      ad.set_available_time
      CompanyMailer.ad_approval(ad.company, ad).deliver
    end

    after_transition :on => :close do |ad|
      unless ad.available?
        ### send mail to company
        CompanyMailer.ad_expired(ad.company, ad).deliver
      end
    end

    after_transition any => :unapproved do |ad|
      AdminNotification.need_check(ad).deliver
    end

    event :want_to_show do
      transition :unapproved => :approving, :if => :company_has_enough_credit?
    end

    event :approve do
      transition any => :opened
    end

    event :close do
      transition any => :closed
    end

    event :reject do
      transition any => :rejected
    end

    event :reapprove do
      transition :rejected => :approving
    end
  end

  validates_presence_of :display_type, :period
  validates_presence_of :name, :province, :city, :url, :if => Proc.new { |ad| ad.display_type == AdPositionType::URGENT_JOB }
  validates_presence_of :name, :url, :if => Proc.new { |ad| [AdPositionType::SLIDER_AD, AdPositionType::FEATURED_COMPANY].include?(ad.display_type) }
  validates_numericality_of :period, :greater_than => 0, :allow_nil => false
  validates_length_of :name, :within => 5..20, :message => "长度必须控制在5-20个字以内。", :if => Proc.new { |ad| ad.display_type != AdPositionType::FAMOUS_COMPANY }
  validate :check_time
  validate :check_image

  ### this seems not work.
  # validates_attachment_presence :image, :message => "必须上传图片。", :if => lambda {|ad| [AdPositionType::SLIDER_AD, AdPositionType::FEATURED_COMPANY].include?(ad.display_type) }
  # validates_attachment_content_type :image, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :message => "只允许上传 jpg, gif, png", :if => lambda {|obj| obj.image.size.present? }
  # validates_attachment_size :image, :less_than => 1.megabytes, :message => "文件尺寸不能大于1M。", :if => lambda {|obj| obj.image.size.present? }
  def check_image
    if [AdPositionType::SLIDER_AD, AdPositionType::FEATURED_COMPANY].include?(self.display_type)
      if self.image.size.blank?
        errors.add :image, "必须上传图片。"
      else
        errors.add :image, "文件尺寸不能大于5M。" if self.image.size > 5.megabytes
        errors.add :image, "只允许上传 jpg, gif, png。" if File.extname(self.image.original_filename) !~ /\.(jpe?g)|(gif)|(png)/i
      end
    end
  end

  def check_time
    errors.add :end_at, '展示结束时间必需大于展示开始时间。' if start_at and end_at and start_at > end_at
  end

  def pay_for_active
    Job.transaction do
      self.user.pay!(self.period, :service_item_id => ServiceItem.send("#{self.display_type_key}_credit_id"), :to => "发布广告##{self.id}")
    end
  end

  def set_available_time
    self.start_at = Date.today
    self.end_at = (self.period*7).days.since.to_date
    self.save
  end

  def company_has_enough_credit?
    return false if self.user.remains(ServiceItem.send("#{self.display_type_key}_credit_id")) < self.period
    return true
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

  def location
    "#{self.try(:province)}#{self.try(:city)}"
  end

  def preview_partial_name
    AdPositionType.enumeration.each do |k, v|
      return k.to_s if v.first == self.display_type
    end
    raise "Wrong ad display type."
  end

  def display_state
    return "已过期" if !self.available? and closed?

    case state
    when 'unapproved'
      "未支付"
    when 'approving'
      "审核中"
    when 'rejected'
      "被拒绝"
    when 'opened'
      "展示中"
    when 'closed'
      "已过期"
    else
      "不明"
    end
  end

  def display_state_font_color
    case display_state
    when "已过期"
      "blue"
    when "未支付", "审核中"
      "gray"
    when "展示中"
      "green"
    when "被拒绝"
      "red"
    end
  end

  def move_lower
    self.decrement!(:position)
  end

  def move_higher
    self.increment!(:position)
  end

  def display_type_key
    DISPLAY_TYPE_KEYS[self.display_type]
  end

  def self.check_all_jobs_availability
    all.each(&:available?)
  end
end
