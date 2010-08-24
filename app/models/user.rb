class User < ActiveRecord::Base
  # attr_accessible :password_confirmation, :password, :login, :email
  acts_as_authentic

  has_one :company
  has_one :partner
  has_one :jobseeker, :class_name => "Resume"

  accepts_nested_attributes_for :company
end