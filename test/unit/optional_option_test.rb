require 'test_helper'

class OptionalOptionTest < ActiveSupport::TestCase
  should "be valid" do
    assert OptionalOption.new.valid?
  end
end
