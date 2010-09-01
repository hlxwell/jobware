# == Schema Information
# Schema version: 20100831035618
#
# Table name: vouchers
#
#  id              :integer(4)      not null, primary key
#  code            :string(255)
#  service_item_id :integer(4)
#  user_id         :integer(4)
#  amount          :integer(4)
#  state           :string(255)
#  created_at      :datetime
#  updated_at      :datetime
#

class Voucher < ActiveRecord::Base
  STATE = ["active", "unactive"]

  belongs_to :service_item
  belongs_to :user

  validates_presence_of :amount, :service_item_id
  validates_inclusion_of :state, :in => STATE

  state_machine :initial => :unactive do
    after_transition :on => :active, :do => :charge_to_bank_account

    event :active do
      transition :unactive => :active
    end
  end

  def Base.before_create
    self.code = MD5.md5(Time.now.to_s)
  end

  def charge_to_bank_account

  end
end
