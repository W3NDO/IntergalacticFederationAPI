# Technical Documentation to get the system setup

Requirements: 
1. Ruby 2.7.4 or higher. If you are using a newer version, remeber to change that in the [Gemfile](./Gemfile)
2. Rails 7.0.4
3. Postgresql should be installed on the target machine

## Setup
1. Once you have the repository on your local machine, open the directory in your terminal and run `bundle install`
2. After installing the required libraries, the next command you should run is `rails db:create` to initialize the database
3. Run `rails db:migrate` to create the required tables in the database
4. Run `rails db:seed` to add in test data to the database
5. If all the above commands run successfully, then you can start the server with `rails s`

Once the server is running, you can access the endpoints defined in the [user documentation](./User%20Documentation.md) on the route `localhost:3000/endpoint` where endpoint is the name of that endpoint. For instance `localhost:3000/pilots`

## Testing
The system uses RSpec to run tests. The tests are defined in the [spec folder](./spec). 
To run the tests, enter the following command in your terminal
```
bundle exec rspec spec
```
This will seed your test database and run all the tests.

If you want to run a specific test, you can use the command 
```
bundle exec rspec spec/path/to/test

for instance 

bundle exec rspec spec/models/pilot_spec.rb
```

Similarly, if you want to run a set of tests, say for the models, you pass the path to the folder containing that set of tests
```
bundle exec rspec path/to/directory
```

