class User < ActiveRecord::Base
  attr_accessible :password_confirmation, :password, :login, :email
  acts_as_authentic
end