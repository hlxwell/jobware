require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::previousJobTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::previousJob.new.valid?
  end
end
