# == Schema Information
# Schema version: 20100825101513
#
# Table name: certifications
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  name       :string(255)
#  get_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#

class Certification < ActiveRecord::Base
  belongs_to :resume
  has_one :image, :as => :imageable

  validates_presence_of :name, :get_at
end