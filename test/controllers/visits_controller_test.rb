require "test_helper"

class VisitsControllerTest < ActionDispatch::IntegrationTest
  test "Should create visit and send email, then redirect to LinkedIn" do
    assert_difference "Visit.count", 1 do
      assert_enqueued_emails 1 do
        get qr_path(destination: "linkedin", location: "test-location")
      end
    end

    visit = Visit.last
    assert_equal "linkedin", visit.destination
    assert_equal "test-location", visit.location

    assert_redirected_to "https://www.linkedin.com/in/andres-felipe-m/?locale=en_US"
  end

  test "should redirect to root with alert for unknown destination" do
  assert_difference "Visit.count", 0 do
    get qr_path(destination: "something-unknown", location: "test-location")
  end

  assert_redirected_to root_path
  follow_redirect!
  assert_match /Invalid destination/, response.body
end
end
