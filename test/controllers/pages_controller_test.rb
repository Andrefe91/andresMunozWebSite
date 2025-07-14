require "test_helper"

class PagesControllerTest < ActionDispatch::IntegrationTest
  test "should get Index" do
    get pages_index_url
    assert_response :success
  end

  test "should get Projects" do
    get projects_url
    assert_response :success
  end

  test "should get Tools" do
    get tools_url
    assert_response :success
  end

  test "should get Contact" do
    get contact_url
    assert_response :success
  end
end
