class StagingJob < ActiveRecord::Base
  validates_uniqueness_of :origin_id, :on => :create, :message => "must be unique"
  validates_uniqueness_of :page_url, :on => :create, :message => "must be unique"
end