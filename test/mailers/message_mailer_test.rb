require "test_helper"

class MessageMailerTest < ActionMailer::TestCase
  def setup
    @communication = communications(:valid_communication) # assuming you have a fixture
  end

  test "new_message email is sent with correct parameters" do
    email = MessageMailer.with(communication: @communication).new_message

    assert_emails 1 do
      email.deliver_now
    end
  end

  test "new_message email has correct recipient" do
    email = MessageMailer.with(communication: @communication).new_message

    assert_equal [ Rails.application.credentials.personal.email ], email.to
  end

  test "new_message email has correct subject" do
    email = MessageMailer.with(communication: @communication).new_message

    assert_equal "New message through the webpage", email.subject
  end

  test "new_message email body contains communication message" do
    email = MessageMailer.with(communication: @communication).new_message
    puts email # Debugging output
    assert_match @communication.message, email.text_part.body.to_s
  end

  test "new_message email body contains communication email" do
    email = MessageMailer.with(communication: @communication).new_message

    puts email.text_part.body
    assert_match @communication.email, email.text_part.body.to_s
  end

  test "new_message email body contains formatted date" do
    email = MessageMailer.with(communication: @communication).new_message
    expected_date = @communication.created_at.strftime("%B %d, %Y at %I:%M %p")

    assert_match expected_date, email.text_part.body.to_s
  end

  test "new_message email body contains greeting" do
    email = MessageMailer.with(communication: @communication).new_message

    assert_match "Hi Andres !!", email.text_part.body.to_s
  end

  test "new_message email body contains header" do
    email = MessageMailer.with(communication: @communication).new_message

    assert_match "New message through the webpage!", email.text_part.body.to_s
  end

  test "new_message email is html format" do
    email = MessageMailer.with(communication: @communication).new_message
    puts email.content_type.split(";").first
    assert_equal "multipart/alternative", email.content_type.split(";").first
  end

  test "new_message works with communication without email" do
    communication_without_email = Communication.create!(
      email: nil,
      message: "Message without email"
    )

    email = MessageMailer.with(communication: communication_without_email).new_message

    assert_not_nil email
    assert_match "Message without email", email.text_part.body.to_s
  end

  test "new_message handles special characters in message" do
    special_communication = Communication.create!(
      email: "test@example.com",
      message: "Message with special chars: <script>alert('xss')</script> & quotes"
    )

    email = MessageMailer.with(communication: special_communication).new_message
    puts email.text_part.body

    # The message should be properly escaped in HTML
    assert_match "Message with special chars:", email.text_part.body.to_s
    # Should not contain unescaped script tags
    refute_match "<script>alert('xss')</script>", email.text_part.body.to_s
  end
end
