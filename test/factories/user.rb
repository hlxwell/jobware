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

Factory.sequence(:email) {|n| "user#{n}@theplant.jp" }

Factory.define :user do |u|
  u.email                 { Factory.next(:email) }
  u.password              "123321"
end