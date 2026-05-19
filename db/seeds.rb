require "faker"

def activated_attributes
  attrs = {}

  if User.column_names.include?("activated")
    attrs[:activated] = true
  end

  if User.column_names.include?("activated_at")
    attrs[:activated_at] = Time.zone.now
  end

  attrs
end

example_user = User.find_or_initialize_by(email: "example@railstutorial.org")
example_user.assign_attributes(
  {
    name: "Example User",
    password: "foobar",
    password_confirmation: "foobar"
  }.merge(activated_attributes)
)
example_user.admin = true if example_user.respond_to?(:admin=)
example_user.save!

99.times do |n|
  name = Faker::Name.name
  email = "example-#{n + 1}@railstutorial.org"

  user = User.find_or_initialize_by(email: email)
  user.assign_attributes(
    {
      name: name,
      password: "password",
      password_confirmation: "password"
    }.merge(activated_attributes)
  )
  user.save!
end

users = User.order(:created_at).take(6)

if Micropost.count.zero?
  50.times do
    content = Faker::Lorem.sentence(word_count: 5)
    users.each do |user|
      user.microposts.create!(content: content)
    end
  end
end

puts "Users: #{User.count}"
puts "Microposts: #{Micropost.count}"
