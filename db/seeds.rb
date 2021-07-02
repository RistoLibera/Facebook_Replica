# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# One account for interaction
User.create!(
  email: '123456@123456.com',
  password: "123456",
  firstname: 'Left', 
  lastname: 'Right', 
  birthday: Faker::Date.between(from: '1900-01-01', to: '2020-12-01'),
  gender: Faker::Gender.binary_type
)



5.times do |i|
  User.create!(
    email: Faker::Internet.unique.email,
    password: "654321",
    firstname: Faker::Name.unique.first_name, 
    lastname: Faker::Name.unique.last_name, 
    birthday: Faker::Date.between(from: '1900-01-01', to: '2020-12-01'),
    gender: Faker::Gender.binary_type
  )
end

3.times do |i|
  Post.create!(
    user: User.all.sample,
    body: Faker::Quote.unique.famous_last_words
  )
end

Request.create!(
  user: User.second,
  friend: User.find_by(firstname: 'Left')
)

Notification.create!(
  user: User.find_by(firstname: 'Left'),
  message: "sent you a friend request.", 
  url: "/users/", 
  sender_id: User.second.id
)

Comment.create!(
  user: User.third,
  post: Post.third,
  content: 'This comment is written by a smart guinea pig.'
)

Post.create!(
  user: User.find_by(firstname: 'Left'),
  body: "You created this post, remember?"
)

Liking.create!(
  user: User.second,
  post: Post.fourth,
)

Notification.create!(
  user: User.find_by(firstname: 'Left'),
  message: "liked your post.", 
  url: "/posts/", 
  sender_id: User.second.id
)
