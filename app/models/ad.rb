# == Schema Information
# Schema version: 20100904140030
#
# Table name: ads
#
#  id           :integer(4)      not null, primary key
#  company_id   :integer(4)
#  position     :integer(4)
#  display_type :integer(4)
#  url          :string(255)
#  state        :string(255)
#  start_at     :date
#  end_at       :date
#  created_at   :datetime
#  updated_at   :datetime
#  province     :string(255)
#  city         :string(255)
#  period       :integer(4)
#

class Ad < ActiveRecord::Base
  include TestExpirationMethods

  DISPLAY_TYPE = AdPositionType.enumeration.values.insert(0, nil).inject do |result, array|
    result ||= {}
    result[array.first] = array.last
    result
  end

  STATE = {
    'active' => "激活",
    'expired' => "过期",
    'unactive' => "未激活"
  }

  has_enumeration_for :display_type, :with => AdPositionType

  belongs_to :company

  has_attached_file :image, :styles => {
    :slideshow => "670x250#",
    :slideshow_small => "520x200#",
    :bottom_ad => "166>x50",
    :featured_job => "310>x80",
    :right_ad => "250>x70"
  }, :default_style => :bottom_ad

  validates_attachment_content_type :image, :content_type => [%r{image/.*jpg}, %r{image/.*jpeg}, %r{image/.*gif}, %r{image/.*png}], :if => lambda {|obj| obj.image.size.present? }
  validates_attachment_size :image, :less_than => 1.megabytes, :if => lambda {|obj| obj.image.size.present? }
  validates_presence_of :name, :url, :province, :city, :display_type, :period

  default_scope order("position desc")

  scope :slider_ads, where(:display_type => AdPositionType::SLIDER_AD).where("? between start_at and end_at", Time.now)
  scope :featured_jobs, where(:display_type => AdPositionType::FEATURED_JOB).where("? between start_at and end_at", Time.now)
  scope :urgent_jobs, where(:display_type => AdPositionType::URGENT_JOB).where("? between start_at and end_at", Time.now)
  scope :right_featured_companies, where(:display_type => AdPositionType::RIGHT_FEATURED_COMPANY).where("? between start_at and end_at", Time.now)
  scope :bottom_featured_companies, where(:display_type => AdPositionType::BOTTOM_FEATURED_COMPANY).where("? between start_at and end_at", Time.now)

  state_machine :initial => :unactive do
    event :active do
      transition :unactive => :active
    end

    event :expire do
      transition :active => :expired
    end
  end

  before_save do
    errors.add :end_at, '展示结束时间必需大于展示开始时间。' if self.start_at and self.end_at and self.start_at > self.end_at
  end

  def location
    loc = self.province + self.city
    loc.blank? ? "全国" : loc
  end

  def preview_partial_name
    AdPositionType.enumeration.each do |k, v|
      return k.to_s if v.first == self.display_type
    end
    raise "Wrong ad display type."
  end

  def display_state
    if expired?(start_at, end_at)
      self.expire! if state != 'expired'
      return "过期"
    end

    case state
    when 'expired'
      "过期"
    when 'unactive'
      "未展示"
    when 'active'
      "展示中"
    else
      "不明"
    end
  end

  def move_lower
    self.decrement!(:position)
  end

  def move_higher
    self.increment!(:position)
  end
end
