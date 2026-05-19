require "test_helper"

class UserMailerTest < ActionMailer::TestCase
  def setup
    @user = User.create!(
      name: "Mailer Test",
      email: "mailer-test@example.com",
      password: "password",
      password_confirmation: "password",
      activated: false
    )
  end

  test "account_activation" do
    @user.activation_token = User.new_token
    mail = UserMailer.account_activation(@user)

    assert_equal [@user.email], mail.to
    assert mail.body.encoded.present?
    assert_match @user.activation_token, mail.body.encoded
  end

  test "password_reset" do
    @user.reset_token = User.new_token
    mail = UserMailer.password_reset(@user)

    assert_equal [@user.email], mail.to
    assert mail.body.encoded.present?
    assert_match @user.reset_token, mail.body.encoded
  end
end
