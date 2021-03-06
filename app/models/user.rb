# -*- encoding : utf-8 -*-
# == Schema Information
# Schema version: 20101014064036
#
# Table name: users
#
#  id                   :integer(4)      not null, primary key
#  email                :string(255)     not null
#  crypted_password     :string(255)     not null
#  password_salt        :string(255)     not null
#  persistence_token    :string(255)     not null
#  single_access_token  :string(255)     not null
#  login_count          :integer(4)      default(0), not null
#  failed_login_count   :integer(4)      default(0), not null
#  last_request_at      :datetime
#  current_login_at     :datetime
#  last_login_at        :datetime
#  current_login_ip     :string(255)
#  last_login_ip        :string(255)
#  created_at           :datetime
#  updated_at           :datetime
#  perishable_token     :string(255)     default(""), not null
#  confirmed_at         :datetime
#  confirmation_sent_at :datetime
#

class User < ActiveRecord::Base
  ROLE = Typus::Configuration.roles.keys.sort
  LANGUAGE = Typus.locales

  include BankAccountMethods
  acts_as_authentic

  %w{company resume partner}.each do |key|
    key_name = key == 'resume' ? "jobseeker" : key
    scope :"#{key_name}_users", joins("LEFT OUTER JOIN #{key.pluralize} ON users.id = #{key.pluralize}.user_id").where("#{key.pluralize}.user_id IS NOT NULL")
  end

  # acts_as_mail_receiver :payload_columns => %w{email},
  #                       :groups => %w{company_users jobseeker_users partner_users}

  has_one :company
  has_one :partner
  has_one :jobseeker, :class_name => "Resume"

  accepts_nested_attributes_for :company
  after_create :send_confirmation_instructions

  def send_confirmation_instructions
    confirmed_at = nil
    confirmation_sent_at = Time.now
    save(:validate => false)
    reset_perishable_token!
    UserMailer.send_confirmation(self).deliver
  end

  def confirmed?
    !(self.new_record? || self.confirmed_at.nil?)
  end

  def confirm!
    update_attribute(:confirmed_at, Time.now)
  end

  class << self
    def disable_perishable_token_maintenance?
      false
    end

    def reset_password(email)
      user = self.find_by_email(email)
      if user.present?
        user.reset_perishable_token!
        UserMailer.reset_password(user).deliver
        true
      else
        false
      end
    end

    def find_and_confirm(perishable_token)
      if confirmable = self.find_using_perishable_token(perishable_token, 1.day)
        confirmable.confirm!
        confirmable
      end
    end

    def find_and_resend_confirmation_instructions(email)
      confirmable = User.find_by_email(email) || User.new

      if confirmable.new_record?
        confirmable.errors.add(:email, "邮箱没有注册过。")
      elsif confirmable.confirmed?
        confirmable.errors.add(:email, "账户已经激活。")
      else
        confirmable.send_confirmation_instructions
      end

      confirmable
    end
  end
end
