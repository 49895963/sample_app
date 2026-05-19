require "test_helper"

class AccountActivationsControllerTest < ActionDispatch::IntegrationTest
  test "should redirect edit with invalid token" do
    get edit_account_activation_url("invalid-token", email: "wrong@example.com")
    assert_redirected_to root_url
  end
end
