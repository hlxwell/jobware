require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::languageTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::language.new.valid?
  end
end
