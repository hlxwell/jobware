# == Schema Information
# Schema version: 20100904140030
#
# Table name: bank_accounts
#
#  id         :integer(4)      not null, primary key
#  user_id    :integer(4)
#  name       :string(255)
#  created_at :datetime
#  updated_at :datetime
#

module BankAccountMethods
  def self.included mod
    # mod.extend ClassMethods
    mod.has_many :transactions, :order => "created_at ASC"
    mod.has_many :positive_transactions
    mod.has_many :negative_transactions
  end

  # module ClassMethods
  #   def acts_as_bank_account
  #     has_many :transactions, :order => "created_at ASC"
  #     has_many :positive_transactions
  #     has_many :negative_transactions
  #   end
  # end

  def remains(service_item_id = ServiceItem.money_id)
    transactions.without_cancelled.where(:service_item_id => service_item_id).sum(:amount)
  end

  # return all kind of remained points
  def all_remains
    ServiceItem.all.map { |item|
      current_remains = remains(item)
      [item, current_remains] if current_remains > 0
    }.compact
  end

  ### basic operations
  ["charge", "pay", "refund", "withdraw"].each do |operation|
    class_eval <<-EOF
      def #{operation}! amount, option = {}
        ensure_positive_number(amount)
        operate_credit!(amount.to_i, "#{operation}", option)
      end
    EOF
  end

  def transactions_for_buying_service
    self.negative_transactions.map { |tx|
      tx if tx.related_object.present?
    }.compact
  end

  private

  def operate_credit! amount, operation, option
    option[:service_item_id] ||= ServiceItem.money_id

    case operation
    when "charge", "refund"
      positive_transactions.create! option.merge(:amount => amount, :to => "account")
    when "pay", "withdraw"
      raise CreditNotEnoughError.new if remains(option[:service_item_id]) < amount.abs
      negative_transactions.create! option.merge(:amount => - amount, :from => "account")
    else
      raise "unknown operation"
    end
  end

  def ensure_positive_number amount
    raise NegativeNumberError.new if amount.blank? or amount.to_i <= 0
  end
end
