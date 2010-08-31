# == Schema Information
# Schema version: 20100824092136
#
# Table name: users
#
#  id                  :integer(4)      not null, primary key
#  login               :string(255)     not null
#  email               :string(255)     not null
#  crypted_password    :string(255)     not null
#  password_salt       :string(255)     not null
#  persistence_token   :string(255)     not null
#  single_access_token :string(255)     not null
#  login_count         :integer(4)      default(0), not null
#  failed_login_count  :integer(4)      default(0), not null
#  last_request_at     :datetime
#  current_login_at    :datetime
#  last_login_at       :datetime
#  current_login_ip    :string(255)
#  last_login_ip       :string(255)
#  created_at          :datetime
#  updated_at          :datetime
#

class User < ActiveRecord::Base
  acts_as_authentic

  has_one :company
  has_one :partner
  has_one :jobseeker, :class_name => "Resume"
  has_one :bank_account, :class_name => "Bank::Account", :as => :parent, :dependent => :destroy

  accepts_nested_attributes_for :company
  
  def Base.after_create
    self.build_bank_account(:name => self.email)
  end
end
