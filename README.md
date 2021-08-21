# Project: Facebook_Replica

## What is this

- This is a simple replica of Facebook, within which has a set of basic functionality to
  prove my understanding of Ruby on Rails and Bulma Framework.

- Online: https://facebook-replica.herokuapp.com/
- Local:  http://localhost:3000/

## What does this have

### As user

- You can create user by firstname, lastname, birthday and gender.
- You can edit your password.
- You can upload images to profile and icon.
- You can add friends or delete friends.
- You can search for what you like.

### For post

- You can create, edit, delete your own posts.
- You can upload images to posts.
- You can like or unlike posts.
- You can comment on any posts.
- You can see when the posts were created.

### Via Facebook

- You can link to Facebook to create a new account(locally).
- You will see the name and email are autofilled(locally).
- PROBLEM: Facebook changed their authentication-system recently, which means the function doesn't work online, but i'm still thinking about a work-around.

## Initial Setup

### Getting start

- Clone repository
```ruby
$ git clone git@github.com:RistoLibera/Facebook_Replica.git
```

- Install gems
```ruby
$ bundle install
```

- Intialize figaro
```ruby
$ bundle exec figaro install
```

- Migrate database
```ruby
$ rails db:migrate
$ rails db:seed
```

- Create server
```ruby
$ rails server
```

- Browse content
```ruby
$ https://localhost:3000
```

### Test Account

- Email: 123456@123456.com
- Password: 123456
