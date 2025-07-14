require "test_helper"

class VisitMailerTest < ActionMailer::TestCase
  test "qr_visit" do
    mail = VisitMailer.qr_visit
    assert_equal "Qr visit", mail.subject
    assert_equal [ "to@example.org" ], mail.to
    assert_equal [ "from@example.com" ], mail.from
    assert_match "Hi", mail.body.encoded
  end
end
