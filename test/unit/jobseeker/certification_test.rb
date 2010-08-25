require 'test_helper'

class Jobseeker::certificationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::certification.new.valid?
  end
end
