# == Schema Information
# Schema version: 20100825101513
#
# Table name: skills
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  name       :string(255)
#  level      :string(255)
#  created_at :datetime
#  updated_at :datetime
#

class Skill < ActiveRecord::Base
  attr_accessible :resume_id, :name, :level
end
