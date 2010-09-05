require 'test_helper'

class Jobseeker::skillTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::skill.new.valid?
  end
end
