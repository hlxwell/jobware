require File.join(File.dirname(__FILE__), '..', 'test_helper')

class RevenueTest < ActiveSupport::TestCase
  should "be valid" do
    assert Revenue.new.valid?
  end
end
