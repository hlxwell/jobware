require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::schoolTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::school.new.valid?
  end
end
