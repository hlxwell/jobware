require 'test_helper'

class StarredResumeTest < ActiveSupport::TestCase
  should "be valid" do
    assert StarredResume.new.valid?
  end
end
