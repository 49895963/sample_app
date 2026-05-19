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
end
