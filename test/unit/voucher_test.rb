require 'test_helper'

class VoucherTest < ActiveSupport::TestCase
  should "be valid" do
    assert Voucher.new.valid?
  end
end
