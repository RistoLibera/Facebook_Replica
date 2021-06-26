# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

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

8.times do |i|
  Post.create!(
    user: User.all.sample,
    body: Faker::Quote.unique.famous_last_words
  )
end
