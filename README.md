# README

* Ruby Version 2.3.8

* Rails Version 5.2.8

#### Instructions

* Clone repo
* Install the bundle as `bundle install`
* Create the file `/config/database.yml` using `/config/database.example` to add the potgresql username and password, followed by creating the database using `rails db:create` and then migrating it using `rails db:migrate`
* Create the initial data by seeding as `rails db:seed`
* Start the server:

```
bundle exec rails server
```

#### Tests

To run all tests:

```
bundle exec rspec
```

#### Running the app

Open the app:

```
http://localhost:3000
```