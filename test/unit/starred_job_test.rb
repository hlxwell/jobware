require 'test_helper'

class StarredJobTest < ActiveSupport::TestCase
  should "be valid" do
    assert StarredJob.new.valid?
  end
end
