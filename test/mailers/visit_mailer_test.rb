require "test_helper"

class VisitMailerTest < ActionMailer::TestCase
  test "qr_visit sends correct email" do
    visit = Visit.new(destination: "linkedin", location: "test-place", ip: "127.0.0.1")

    email = VisitMailer.with(visit: visit).qr_visit

    assert_emails 1 do
      email.deliver_now
    end

    assert_equal [ Rails.application.credentials.dig(:personal, :email) ], email.to
    assert_equal [ "andresmunoz.me" ], email.from
    assert_equal "New visit through the QR card", email.subject
    assert_match /linkedin/i, email.body.encoded
  end
end
