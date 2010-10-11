ENV["RAILS_ENV"] = "test"
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'shoulda'
require 'factory_girl'
require 'pp'

Factory.definition_file_paths = [ File.join(Rails.root, 'test', 'factories') ]
Factory.find_definitions

class ActiveSupport::TestCase
  # Setup all fixtures in test/fixtures/*.(yml|csv) for all tests in alphabetical order.
  #
  # Note: You'll currently still have to declare fixtures explicitly in integration tests
  # -- they do not yet inherit this setting
  # fixtures :all
  # Add more helper methods to be used by all tests here...
  
  def add_service_items
    ServiceItem.create(:name => "人民币", :desc => "帐户里的现金用于购买服务。", :service_length => 0)
    ServiceItem.create(:name => "岗位发布", :desc => "用户发布岗位。", :service_length => 30)
    ServiceItem.create(:name => "岗位高亮显示", :desc => "用于使岗位高亮显示。", :service_length => 30)
    ServiceItem.create(:name => "紧急招聘", :desc => "用于发布'紧急招聘'广告。", :service_length => 7)
    ServiceItem.create(:name => "首页滚动图片", :desc => "用于发布'首页滚动图片'广告。", :service_length => 7)
    ServiceItem.create(:name => "推荐企业", :desc => "用于发布'推荐企业'广告。", :service_length => 7)
    ServiceItem.create(:name => "知名企业招聘", :desc => "用于发布'知名企业招聘'广告。", :service_length => 7)
  end
end