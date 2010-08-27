require 'test_helper'

class JobApplicationTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert JobApplication.new.valid?
  end
end
