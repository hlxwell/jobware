require File.join(File.dirname(__FILE__), '..', 'test_helper')

class Jobseeker::coverLetterTest < ActiveSupport::TestCase
  def test_should_be_valid
    assert Jobseeker::coverLetter.new.valid?
  end
end
