require 'test_helper'

class CompanyMailerTest < ActionMailer::TestCase
  test "new_applicant" do
    mail = CompanyMailer.new_applicant
    assert_equal "New applicant", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
