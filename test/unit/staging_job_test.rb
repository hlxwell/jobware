require 'test_helper'

class StagingJobTest < ActiveSupport::TestCase
  should "be valid" do
    assert StagingJob.new.valid?
  end
end
