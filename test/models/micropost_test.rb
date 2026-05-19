require "test_helper"

class MicropostTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      name: "Micropost Test",
      email: "micropost-test@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @micropost = @user.microposts.build(content: "Lorem ipsum")
  end

  test "should be valid" do
    assert @micropost.valid?
  end

  test "user id should be present" do
    @micropost.user_id = nil
    assert_not @micropost.valid?
  end

  test "content should be present" do
    @micropost.content = "   "
    assert_not @micropost.valid?
  end

  test "content should be at most 140 characters" do
    @micropost.content = "a" * 141
    assert_not @micropost.valid?
  end

  test "order should be most recent first" do
    @user.microposts.create!(content: "Old post", created_at: 1.day.ago)
    newer = @user.microposts.create!(content: "New post", created_at: Time.zone.now)

    assert_equal newer, Micropost.first
  end
end
