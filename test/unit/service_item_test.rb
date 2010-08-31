require 'test_helper'

class ServiceItemTest < ActiveSupport::TestCase
  should "be valid" do
    assert ServiceItem.new.valid?
  end
end
