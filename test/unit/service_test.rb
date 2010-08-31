require 'test_helper'

class ServiceTest < ActiveSupport::TestCase
  should "be valid" do
    assert Service.new.valid?
  end
end
