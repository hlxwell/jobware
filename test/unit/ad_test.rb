# -*- encoding : utf-8 -*-
require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AdTest < ActiveSupport::TestCase
  context "slider ads" do
    setup do
      @hash = {
        :name => "rails job",
        :desc => "好工作",
        :url => "http://itjob.fm",
        :period => 1,
        :image => File.open(File.join(Rails.root, "test", "files", "file.gif"))
      }
    end

    should "needs necessary columns" do
      ad = Ad.new @hash.merge!({:display_type => AdPositionType::SLIDER_AD})
      assert ad.valid?
    end
  end

  context "urgent jobs" do
    setup do
      @hash = {
        :name => "rails job",
        :province => "浙江",
        :city => "杭州",
        :url => "http://itjob.fm",
        :period => 1
      }
    end

    should "needs necessary columns" do
      ad = Ad.new @hash.merge!({:display_type => AdPositionType::URGENT_JOB})
      assert ad.valid?
    end
  end

  context "famous_companies" do
    setup do
      @hash = {
        :period => 1
      }
    end

    should "needs necessary columns" do
      ad = Ad.new @hash.merge!({:display_type => AdPositionType::FAMOUS_COMPANY})
      assert ad.valid?
    end
  end

  context "featured_companies" do
    setup do
      @hash = {
        :name => "rails job",
        :url => "http://itjob.fm",
        :period => 1,
        :image => File.open(File.join(Rails.root, "test", "files", "file.gif"))
      }
    end

    should "needs necessary columns" do
      ad = Ad.new @hash.merge!({:display_type => AdPositionType::FEATURED_COMPANY})
      assert ad.valid?
    end
  end

end
