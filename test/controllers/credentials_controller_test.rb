require "test_helper"

class CredentialsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get credentials_new_url
    assert_response :success
  end
end
