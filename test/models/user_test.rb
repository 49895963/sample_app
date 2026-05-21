require "test_helper"

class UserTest < ActiveSupport::TestCase

  test "associated microposts should be destroyed" do
    user = User.create!(
      name: "Destroy Test",
      email: "destroy-test@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    user.microposts.create!(content: "Lorem ipsum")

    assert_difference "Micropost.count", -1 do
      user.destroy
    end
  end
  test "should follow and unfollow a user" do
    michael = User.create!(
      name: "Michael Example",
      email: "michael-follow@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    archer = User.create!(
      name: "Sterling Archer",
      email: "archer-follow@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    assert_not michael.following?(archer)

    michael.follow(archer)
    assert michael.following?(archer)
    assert archer.followers.include?(michael)

    michael.unfollow(archer)
    assert_not michael.following?(archer)
  end

  test "feed should have the right posts" do
    michael = User.create!(
      name: "Feed Michael",
      email: "feed-michael@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    archer = User.create!(
      name: "Feed Archer",
      email: "feed-archer@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    lana = User.create!(
      name: "Feed Lana",
      email: "feed-lana@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    michael.follow(archer)

    own_post = michael.microposts.create!(content: "Post from myself")
    followed_post = archer.microposts.create!(content: "Post from followed user")
    unfollowed_post = lana.microposts.create!(content: "Post from unfollowed user")

    assert michael.feed.include?(own_post)
    assert michael.feed.include?(followed_post)
    assert_not michael.feed.include?(unfollowed_post)
  end

end
