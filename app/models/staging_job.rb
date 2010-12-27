# == Schema Information
# Schema version: 20101224032047
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
#

class StagingJob < ActiveRecord::Base
  validates_uniqueness_of :origin_id, :on => :create, :message => "must be unique"
  validates_uniqueness_of :page_url, :on => :create, :message => "must be unique"
end
