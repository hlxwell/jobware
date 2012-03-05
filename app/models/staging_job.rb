# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20110108150514
#
# Table name: staging_jobs
#
#  id                    :integer(4)      not null, primary key
#  name                  :string(255)
#  location              :string(255)
#  vacancy               :string(255)
#  industry              :string(255)
#  salary_range          :string(255)
#  work_year_requirement :string(255)
#  degree_requirement    :string(255)
#  contact               :string(255)
#  state                 :string(255)
#  page_url              :string(255)
#  origin_id             :string(255)
#  desc                  :text
#  company_name          :string(255)
#  company_desc          :text
#  created_at            :datetime
#  updated_at            :datetime
#  company_size          :string(255)
#  company_type          :string(255)
#  company_homepage      :string(255)
#  company_address       :string(255)
#  company_phone_number  :string(255)
#  company_contact_name  :string(255)
#  email                 :string(255)
#

class StagingJob < ActiveRecord::Base
  default_scope order("state asc, created_at desc")
  scope :published, where(:state => "published")
  scope :unpublished, where(:state => "0")

#  validates_uniqueness_of :origin_id, :on => :create, :message => "must be unique"
  validates_uniqueness_of :page_url, :on => :create, :message => "must be unique"

  before_create :read_text_from_js

  def read_text_from_js
    self.attributes.each do |k, v|
      if v =~ /^http:\/\/.*zhaopin.com\/.*\.js$/
        if content = `curl #{v}|iconv -f utf-16 -t utf-8`
          self.send("#{k}=", content.gsub(/document.write \(\"|(\"\);)/, ''))
        end
      end
    end
  end
end
