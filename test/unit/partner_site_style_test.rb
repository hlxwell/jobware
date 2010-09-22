require File.join(File.dirname(__FILE__), '..', 'test_helper')

class PartnerSiteStyleTest < ActiveSupport::TestCase
  should "be valid" do
    assert PartnerSiteStyle.new.valid?
  end
end
