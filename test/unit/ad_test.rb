require File.join(File.dirname(__FILE__), '..', 'test_helper')

class AdTest < ActiveSupport::TestCase
  should "be valid" do
    assert Ad.new.valid?
  end
end
