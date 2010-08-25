require 'test_helper'

class Partner:adPositionTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Partner:adPosition.new.valid?
  end
end
