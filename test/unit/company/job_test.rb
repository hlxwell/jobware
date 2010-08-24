require 'test_helper'

class Company::jobTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Company::job.new.valid?
  end
end
