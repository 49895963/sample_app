require "test_helper"

class ReactionTest < ActiveSupport::TestCase
  def setup
    @user = User.create!(
      name: "Reaction User",
      email: "reaction-user@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @micropost = @user.microposts.create!(content: "Reaction test post")
    @reaction = @user.reactions.build(micropost: @micropost)
  end

  test "should be valid" do
    assert @reaction.valid?
  end

  test "user id should be present" do
    @reaction.user_id = nil
    assert_not @reaction.valid?
  end

  test "micropost id should be present" do
    @reaction.micropost_id = nil
    assert_not @reaction.valid?
  end

  test "user should not react to same micropost twice" do
    @reaction.save!
    duplicate = @user.reactions.build(micropost: @micropost)
    assert_not duplicate.valid?
  end
end
