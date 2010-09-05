class Transaction < ActiveRecord::Base
  default_scope where(:deleted_at => nil)
  scope :with_deleted, where("deleted_at IS NOT NULL")
  scope :without_cancelled, where(:cancelled_at => nil)

  belongs_to :bank_account
  belongs_to :service_item
  belongs_to :related_object, :polymorphic => true

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
end