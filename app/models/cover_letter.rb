# == Schema Information
# Schema version: 20100825101513
#
# Table name: cover_letters
#
#  id         :integer(4)      not null, primary key
#  resume_id  :integer(4)
#  name       :string(255)
#  content    :text
#  created_at :datetime
#  updated_at :datetime
#

class CoverLetter < ActiveRecord::Base
  attr_accessible :name, :content, :resume_id
end
