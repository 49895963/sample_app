require "test_helper"

class JapaneseErrorMessagesTest < ActiveSupport::TestCase
  test "user validation error messages are Japanese" do
    user = User.new(
      name: "",
      email: "",
      password: "short",
      password_confirmation: "short"
    )

    assert_not user.valid?

    messages = user.errors.full_messages
    assert_includes messages, "名前を入力してください"
    assert_includes messages, "メールアドレスを入力してください"
    assert_includes messages, "パスワードは6文字以上で入力してください"
  end

  test "micropost validation error messages are Japanese" do
    user = User.create!(
      name: "Japanese Error Test",
      email: "japanese-error-test@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    micropost = user.microposts.build(content: "")

    assert_not micropost.valid?
    assert_includes micropost.errors.full_messages, "投稿内容を入力してください"
  end
end
