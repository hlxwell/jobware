# == Schema Information
# Schema version: 20100831035618
#
# Table name: ads
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  position   :integer(4)
#  type       :integer(4)
#  url        :string(255)
#  state      :string(255)
#  start_at   :date
#  end_at     :date
#  created_at :datetime
#  updated_at :datetime
#

class Ad < ActiveRecord::Base
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
  
  include TestExpirationMethods

  has_enumeration_for :display_type, :with => AdPositionType

  validates_presence_of :url, :province, :city, :display_type, :period

  belongs_to :company
  has_one :image, :class_name => 'TitledImage', :as => :parent, :dependent => :destroy

  accepts_nested_attributes_for :image

  delegate :name, :name=, :desc, :desc=, :file, :file=, :to => :image

  default_scope order("position desc")

  scope :slider_ads, where(:display_type => AdPositionType::SLIDER_AD, :state => :active)
  scope :featured_jobs, where(:display_type => AdPositionType::FEATURED_JOB, :state => :active)
  scope :urgent_jobs, where(:display_type => AdPositionType::URGENT_JOB, :state => :active)
  scope :right_featured_companies, where(:display_type => AdPositionType::RIGHT_FEATURED_COMPANY, :state => :active)
  scope :bottom_featured_companies, where(:display_type => AdPositionType::BOTTOM_FEATURED_COMPANY, :state => :active)

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