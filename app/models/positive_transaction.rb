class PositiveTransaction < Transaction
  validates_numericality_of :amount, :greater_than => 0
end