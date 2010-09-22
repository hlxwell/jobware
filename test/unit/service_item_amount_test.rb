require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ServiceItemAmountTest < ActiveSupport::TestCase
  should "be valid" do
    assert ServiceItemAmount.new.valid?
  end
end
