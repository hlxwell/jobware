require 'test_helper'

class SubscriptionTest < ActiveSupport::TestCase
  should "be valid" do
    assert Subscription.new.valid?
  end
end
