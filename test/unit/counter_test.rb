require 'test_helper'

class CounterTest < ActiveSupport::TestCase
  should "be valid" do
    assert Counter.new.valid?
  end
end
