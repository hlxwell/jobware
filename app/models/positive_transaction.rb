# == Schema Information
# Schema version: 20100910083810
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
#  amount              :integer(4)
#  note                :string(255)
#  cancel_reason       :string(255)
#  cancelled_at        :datetime
#  deleted_at          :datetime
#  created_at          :datetime
#  updated_at          :datetime
#

class PositiveTransaction < Transaction
  validates_numericality_of :amount, :greater_than => 0
end
