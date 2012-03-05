# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20100830092146
#
# Table name: adclicks
#
#  id              :integer(4)      not null, primary key
#  ad_position_id  :integer(4)
#  remote_ip       :string(255)
#  source_page     :string(255)
#  dest_page       :string(255)
#  http_user_agent :string(255)
#  remote_host     :string(255)
#  request_uri     :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Adclick < ActiveRecord::Base
  belongs_to :ad_position

  validates_uniqueness_of :remote_ip, :on => :create, :if => Proc.new { |click|
    Adclick.where(:remote_ip => click.remote_ip, :created_at => 1.hour.ago..Time.now).count > 0
  }
  validates_presence_of :ad_position_id, :remote_ip, :dest_page
end
