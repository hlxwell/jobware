# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20100831053852
#
# Table name: starred_resumes
#
#  id         :integer(4)      not null, primary key
#  company_id :integer(4)
#  resume_id  :integer(4)
#  rating     :integer(4)
#  created_at :datetime
#  updated_at :datetime
#

class StarredResume < ActiveRecord::Base
  belongs_to :company
  belongs_to :resume
end
