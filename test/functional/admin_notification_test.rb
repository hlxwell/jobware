require 'test_helper'

class AdminNotificationTest < ActionMailer::TestCase
  test "need_check" do
    mail = AdminNotification.need_check
    assert_equal "Need check", mail.subject
    assert_equal ["to@example.org"], mail.to
    assert_equal ["from@example.com"], mail.from
    assert_match "Hi", mail.body.encoded
  end

end
