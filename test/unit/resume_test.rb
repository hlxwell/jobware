require File.join(File.dirname(__FILE__), '..', 'test_helper')

class ResumeTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Resume.new.valid?
  end
end
