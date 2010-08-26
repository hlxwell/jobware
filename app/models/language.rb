# == Schema Information
# Schema version: 20100825101513
#
# Table name: languages
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  name       :string(255)
#  level      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Language < ActiveRecord::Base
  belongs_to :resume
  validates_presence_of :name, :level
end