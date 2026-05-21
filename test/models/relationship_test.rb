require "test_helper"

class RelationshipTest < ActiveSupport::TestCase
  def setup
    @follower = User.create!(
      name: "Follower User",
      email: "follower@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @followed = User.create!(
      name: "Followed User",
      email: "followed@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @relationship = @follower.active_relationships.build(followed_id: @followed.id)
  end

  test "should be valid" do
    assert @relationship.valid?
  end

  test "follower id should be present" do
    @relationship.follower_id = nil
    assert_not @relationship.valid?
  end

  test "followed id should be present" do
    @relationship.followed_id = nil
    assert_not @relationship.valid?
  end
end
