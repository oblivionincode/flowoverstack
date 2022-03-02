# Create a main sample user.
User.create!(name:  "Example User",
             email: "example@fos.com",
             password:              "foobar",
             password_confirmation: "foobar",
             admin: true)

99.times do |n|
  name  = Faker::Name.name
  email = "example-#{n+1}@fos.com"
  password = "password"
  User.create!(name:  name,
               email: email,
               password:              password,
               password_confirmation: password)
end
# Generate Questions for a subset of users.
users = User.order(:created_at).take(6)
50.times do
  title = Faker::Lorem.sentence(word_count: 5)
  content = Faker::Lorem.sentence(word_count: 20)
  users.each { |user| user.questions.create!(title: title, content: content) }
end
