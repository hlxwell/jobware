require 'test_helper'

class Jobseeker::projectTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::project.new.valid?
  end
end
