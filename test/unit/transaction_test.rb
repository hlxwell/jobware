require File.join(File.dirname(__FILE__), '..', 'test_helper')

class TransactionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Transaction.new.valid?
  end
end
