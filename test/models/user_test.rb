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

end
