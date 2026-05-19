require "test_helper"

class PasswordResetsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = User.create!(
      name: "Password Reset Test",
      email: "password-reset-test@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )
    @user.create_reset_digest
  end

  test "should get new" do
    get new_password_reset_url
    assert_response :success
  end

  test "should get edit" do
    get edit_password_reset_url(@user.reset_token, email: @user.email)
    assert_response :success
  end
end
