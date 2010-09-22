require File.join(File.dirname(__FILE__), '..', 'test_helper')

class StarredJobTest < ActiveSupport::TestCase
  should "be valid" do
    assert StarredJob.new.valid?
  end
end
