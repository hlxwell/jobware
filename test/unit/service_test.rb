require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ServiceTest < ActiveSupport::TestCase
  should "be valid" do
    assert Service.new.valid?
  end
end
