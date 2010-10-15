# == Schema Information
# Schema version: 20101014064036
#
# Table name: transactions
#
#  id                  :integer(4)      not null, primary key
#  type                :string(255)
#  user_id             :integer(4)
#  service_item_id     :integer(4)
#  related_object_id   :integer(4)
#  related_object_type :string(255)
#  from                :string(255)
#  to                  :string(255)
#  amount              :float
#  note                :text(16777215)
#  cancel_reason       :string(255)
#  cancelled_at        :datetime
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#  partner_id          :integer(4)
#

class Transaction < ActiveRecord::Base
  default_scope where(:deleted_at => nil)
  scope :with_deleted, where("deleted_at IS NOT NULL")
  scope :without_cancelled, where(:cancelled_at => nil)

  belongs_to :partner
  belongs_to :user
  belongs_to :service_item
  belongs_to :related_object, :polymorphic => true

  def is_money?
    self.service_item_id == ServiceItem.money_id
  end

  def cancel!(reason = nil)
    raise NoCancelReasonError.new if reason.blank?
    update_attributes :cancel_reason => reason, :cancelled_at => Time.now
  end

  def cancelled?
    cancelled_at.present?
  end

  def destroy
    update_attribute(:deleted_at, Time.now)
  end

  def amount_s
    amount > 0 ? "+#{amount}" : "#{amount}"
  end

end
