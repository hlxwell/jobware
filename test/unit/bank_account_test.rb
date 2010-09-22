require File.join(File.dirname(__FILE__), '..', 'test_helper')

class BankAccountTest < ActiveSupport::TestCase
  should "be valid" do
    assert BankAccount.new.valid?
  end
end
