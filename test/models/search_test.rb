require "test_helper"

class SearchTest < ActiveSupport::TestCase
  def setup
    @alice = User.create!(
      name: "Alice Search",
      email: "alice-search@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @bob = User.create!(
      name: "Bob Sample",
      email: "bob-sample@example.com",
      password: "password",
      password_confirmation: "password",
      activated: true,
      activated_at: Time.zone.now
    )

    @alice_post = @alice.microposts.create!(content: "Ruby search keyword")
    @bob_post = @bob.microposts.create!(content: "Different content")
  end

  test "user search matches name" do
    results = User.search("Alice").to_a

    assert_includes results, @alice
    assert_not_includes results, @bob
  end

  test "user search matches email" do
    results = User.search("bob-sample").to_a

    assert_includes results, @bob
    assert_not_includes results, @alice
  end

  test "micropost search matches content" do
    results = Micropost.search("Ruby").to_a

    assert_includes results, @alice_post
    assert_not_includes results, @bob_post
  end
end
