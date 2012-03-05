# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20101027063250
#
# Table name: optional_options
#
#  id          :integer(4)      not null, primary key
#  parent_id   :integer(4)
#  parent_type :string(255)
#  type        :string(255)
#  name        :string(255)
#  desc        :string(255)
#  created_at  :datetime
#  updated_at  :datetime
#

class QuestionOption < OptionalOption
end
