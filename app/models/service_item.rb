# == Schema Information
# Schema version: 20100901023638
#
# Table name: service_items
#
#  id             :integer(4)      not null, primary key
#  name           :string(255)
#  desc           :text
#  service_length :integer(4)
#  created_at     :datetime
#  updated_at     :datetime
#

class ServiceItem < ActiveRecord::Base
  validates_presence_of :name, :desc, :service_length
  validates_uniqueness_of :name

  has_many :service_item_amounts
  has_many :service, :through => :service_item_amounts

  CREDIT_TYPE_HASH = {
    :money => "人民币",
    :job_credit => "岗位发布",
    :job_highlight_credit => "岗位高亮显示",
    :urgent_job_credit => "紧急招聘",
    :slider_ad_credit => "首页滚动图片广告",
    :featured_company_credit => "推荐企业",
    :famous_company_credit => "知名企业招聘"
  }

  class << self
    CREDIT_TYPE_HASH.each do |key, value|
      define_method("#{key}_id") do |*args|
        ServiceItem.get_id_by_name(value)
      end
    end
  end

  CREDIT_TYPE_HASH.each do |key, value|
    define_method("is_#{key}?") do |*args|
      ServiceItem.send("#{key}_id") == self.id
    end
  end

  def self.get_id_by_name(name)
    ServiceItem.find_by_name(name).try(:id)
  end
end