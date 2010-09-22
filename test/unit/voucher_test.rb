require File.join(File.dirname(__FILE__), '..', 'test_helper')

class VoucherTest < ActiveSupport::TestCase
  should "be valid" do
    assert Factory(:voucher).new.valid?
  end
end
