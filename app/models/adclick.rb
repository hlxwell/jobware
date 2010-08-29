class Adclick < ActiveRecord::Base
  belongs_to :ad_position

  validates_uniqueness_of :remote_ip, :on => :create, :if => Proc.new { |click|
    Adclick.where(:remote_ip => click.remote_ip, :created_at => 1.hour.ago..Time.now).count > 0
  }
  validates_presence_of :ad_position_id, :remote_ip, :dest_page
end