require 'test_helper'

class PartnerMailerTest < ActionMailer::TestCase
  test "approval" do
    mail = PartnerMailer.approval
    assert_equal "Approval", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "daily_report" do
    mail = PartnerMailer.daily_report
    assert_equal "Daily report", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

  test "monthly_report" do
    mail = PartnerMailer.monthly_report
    assert_equal "Monthly report", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
