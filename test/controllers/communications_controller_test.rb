require "test_helper"

class CommunicationsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @communication = Communication.create!(
      message: "Test message",
      email: "test@example.com"
    )
  end

  # INDEX tests
  # test "should get index" do
  #   get communications_url
  #   assert_response :success
  # end

  # test "should assign all communications to @communications" do
  #   communication1 = Communication.create!(message: "Test message 1", email: "test1@example.com")
  #   communication2 = Communication.create!(message: "Test message 2", email: "test2@example.com")

  #   get communications_url
  #   assert_response :success
  # end

  # CREATE tests - Valid cases
  test "should create communication with valid attributes" do
    assert_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "This is a test message",
          email: "test@example.com"
        }
      }
    end

    assert_redirected_to root_path
    assert_equal "Communication was successfully created.", flash[:notice]
  end

  test "should create communication without email" do
    assert_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "This is a test message without email",
          email: ""
        }
      }
    end

    assert_redirected_to root_path
    communication = Communication.last
    assert_equal "This is a test message without email", communication.message
    assert communication.email.blank?
  end

  test "should save communication with correct attributes" do
    post communications_url, params: {
      communication: {
        message: "Specific test message",
        email: "specific@example.com"
      }
    }

    communication = Communication.last
    assert_equal "Specific test message", communication.message
    assert_equal "specific@example.com", communication.email
  end

  # CREATE tests - Invalid cases
  test "should not create communication with empty message" do
    assert_no_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "",
          email: "test@example.com"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not create communication with invalid email format" do
    assert_no_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "Valid message",
          email: "invalid-email-format"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not create communication with message too long" do
    long_message = "a" * 501 # Exceeds 500 character limit

    assert_no_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: long_message,
          email: "test@example.com"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should not create communication with email too long" do
    long_email = "a" * 250 + "@example.com" # Exceeds 255 character limit

    assert_no_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "Valid message",
          email: long_email
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should handle missing communication parameters" do
    post communications_url, params: { other_param: "value" }
    assert_response :unprocessable_entity
  end

  # Additional edge cases
  test "should handle nil message" do
    assert_no_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: nil,
          email: "test@example.com"
        }
      }
    end

    assert_response :unprocessable_entity
  end

  test "should accept maximum length message" do
    max_message = "a" * 500 # Exactly 500 characters

    assert_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: max_message,
          email: "test@example.com"
        }
      }
    end

    assert_redirected_to root_path
  end

  test "should accept maximum length email" do
    # Create an email that's exactly 255 characters
    max_email = "a" * 243 + "@example.com" # 243 + 12 = 255 characters

    assert_difference("Communication.count") do
      post communications_url, params: {
        communication: {
          message: "Test message",
          email: max_email
        }
      }
    end

    assert_redirected_to root_path
  end
end
