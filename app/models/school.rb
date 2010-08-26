# == Schema Information
# Schema version: 20100825101513
#
# Table name: schools
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  name       :string(255)
#  major      :string(255)
#  start_at   :datetime
#  end_at     :datetime
#  created_at :datetime
#  updated_at :datetime
#

class School < ActiveRecord::Base
  belongs_to :resume
  validates_presence_of :name, :major, :start_at, :end_at
end
