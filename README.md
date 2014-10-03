## Stripe Test

This is a test deployment that creates a new Rails app and gets a test Stripe application up and running.

The primary goal of this is to document the required steps to:

1. Generate a new rails app
1. Create a basic inventory
1. Create a basic shopping cart
1. Hook up Stripe processing
1. Complete viable transactions
1. Modify for subscription use

I will also endeavor to document lessons learned and options.  Upon completion, cloning this repository should establish a basic e-commerce website with normally required options, including a full test suite and basic configurable pages, suitable for use in consultancy/ contract work for e-commerce sites.

This will rely heavily on tutorials from Hartl, RailsCasts, RailsGirls, and Stripe.

## Destructions: Version 1.

### Prerequisites
1. Ruby is installed - [instructions](https://github.com/SRozick/middleman-foundation-min/wiki/Welcome-to-the-middleman-foundation-min-wiki! "Installing Rails Wiki")
1. Rails is installed - [instructions](https://github.com/SRozick/middleman-foundation-min/wiki/Installing-and-Configuring-Rails "Installing Rails Wiki")
1. RVM is being used as gemset version control- [instructions](https://github.com/SRozick/middleman-foundation-min/wiki/Welcome-to-the-middleman-foundation-min-wiki! "Installing Rails Wiki")
1. Postgres is installed and setup - [instructions](https://github.com/SRozick/middleman-foundation-min/wiki/Welcome-to-the-middleman-foundation-min-wiki! "Installing Rails Wiki")
  1. gem install pg 
  1. PGadmin is installed and set up - [pgadmin](http://www.pgadmin.org) 

### Cloning instructions
1. `$ git clone git@github.com:SRozick/stripeTest.git`
1. `$ cd stripeTest.git`
1. `$ rvm gemset use <rails_ver>@stripeTest --create`
1. Copy config/database.yml.sample and rename to config/database.yml (database.yml is ignored by git)  
  1. In `config/database.yml`: 
    1. Under `default:`, add `username:<local_username>`
    1. Under `development:`, `test:`, and `production:`, change `database:` to appropriate database name
1. Copy config/secrets.yml.sample and rename to config/secrets.yml (secrets.yml is ignored by git)
  1. In `config/secrets.yml`: 
    1. Run `rake secret` and insert the results under `development:` 
    1. Run `rake secret` (again) and insert the results under `test:` 
1. `$ bundle install`
2. `$ bundle update`
3. `$ rake db:create`
4. `$ rails s`
  1. Observe smoke test page in browser at localhost:3000 :-) 

### Steps to create
1. `$ rails new <project_name> --database=postgresql --no-test-framework`
1. `$ cd <project_name>`
1. `$ subl .`
1. `$ rvm gemset use <rails_ver>@<project_name> --create
1. Edit Gemfile
  1. All of the following steps can be implemented using a template or by modifying the `rails new` generator process.
  1. Comment out turbolinks.  [Why?](https://github.com/SRozick/stripeTest/blob/master/README.md#turbolinks)
  1. Replace rubyracer with execjs.  [Why?](https://github.com/SRozick/stripeTest/blob/master/README.md#nodejs)
    1. In `Gemfile`:  `gem execjs`
    1. In `config/boot.rb`: `ENV['EXECJS_RUNTIME'] = 'Node'` OR [see here](http://ajacevedo.com/2013/using-node-js-as-a-rails-javascript-runtime/) for alternative method.
  1. Remove remaining comments (to avoid clutter)
1. Edit config/database.yml
  1. Copy database.yml and rename to database.yml.sample (database.yml will be ignored by git)  
  1. Under `default:`, add `username:<local_username>`
  1. Under `development:` and under `test:`, remove or comment out `username:<value>`
1. Create basic product inventory as Widgets
          
        $ rails generate scaffold widgets name:string description:text 
          picture:integer price:decimal
          
          # note there should not be a line break

1. Create basic test suite
  1. Add required gems to `Gemfile` 
              
          group :development, :test do
            gem 'spring-commands-rspec'
            gem 'rspec-rails'
            gem 'guard-rspec'
            gem 'factory\_girl_rails'
            gem 'faker'
            gem 'capybara'
          end

          group :test do
            gem 'launchy'
          end
  1. `$ bundle`
  1. `rails generate rspec:install`
  1. Edit `spec/spec_helper`:
    1. Add the following at the top of the file:

            require "capybara/rspec"
            require "rails_helper"
    1. Remove `=begin` from around line 45 and `=end` from around line 86  
      (We want to use recommended settings).
    1. Comment out `config.profile_examples = 10` around line 71  
      (For short tests this becomes too verbose to easily see results).
    1. Comment out `config.disable_monkey_patching!` around line 56  
      (This seems to break the standard-ish `describe` syntax).
  1. `$ mkdir spec/models`
  1. `$ mkdir spec/factories`
  1. Create file `spec/models/widget_spec.rb`and supporting factory `spec/factories/widgets.rb` (see files)
  1. 

---------
### Troubleshooting
---------
### Other Useful Notes

##### Capybara

Capybara simulates how a real-world user is going to interact with the application, for example, by filling in forms or clicking objects.  Capybara is part of the guard/rspec test environment.

##### Factory\_girl_rails

Factory Girl generates objects for purposes of testing.  It helps maintain DRY test code by consolidating test objects into a single location and configuration that can be called when required and in quantities as required.  This is part of the guard/rspec test environment.

##### Faker

Faker generates fake name and address data (and passwords, products, etc) for purposes of more advanced testing.  When tests require a variety of different data, faker generates the data for the tests.  

Faker is also useful for generating screenshots and demonstration platforms, when real customer data isn't available or shouldn't be compromised.

##### Guard-spec

Part of the Guard suite of management tools, guard-rspec provides Guard functionality to rspec files and tests.  Basically this means that Guard will watch in the background and when a test file changes, Guard will automatically re-run the associated tests.  The developer receives a flag when tests pass or fail and does not have to pause development activity to test.

The advantage of this is that tests run faster by not having to pre-load the environment each time; the test environment is maintained as development continues.  Tests run in the background and output is fed to various   

##### Launchy

Launchy launches a browser instance for testing purposes when required.  Launchy is part of the guard/rspec test environment.

##### Nodejs

Nodejs and therubyracer gems are both javascript runtime environments that permit the server to run javascript applications and return the results to Ruby/ Rails when required.  They allow advanced linking between the client and browser, and when properly used, result in faster client response with lower server loading.

While there appears to be an ongoing community discussion as to the benefits of using nodejs, therubyracer, or therubyrhino, nodejs is selected here because the use of its alternatives is discouraged by Heroku.  This appears to be due to the size of nodejs, and possible related performance issues.  Nonetheless, as most projects developed from this repo will likely be deployed to Heroku servers first, and because development, test, and production environments should match as closely as possible, nodejs is the preferred gem here.

Using nodejs involves requiring the execjs gem and modifying `config/boot.rb` file to ensure nodejs is applied at application runtime. 

To be clear, there is no particular preference other than consistency at this stage, to use nodejs, therubyracer, or therubyrhino gems.

##### Rspec-rails

Rspec-rails provides the testing framework for all tests that will be run.  It is supported by guard-rspec, factory\_girl_rails, and spring-commands-rspec. 

Rspec allows for Behaviour Driven Development (BDD) in Rails applications.  The stripeTest rspec suite will begin with a full set of feature tests.  These serve to 1) Validate stripeTest is behaving as expected, 2) illustrate features and behaviour of stripeTest by way of internal documentation, and 3) document the extent to which the code is already tested.

##### Spring-commands-rspec

Integrates spring and rspec.

##### Turbolinks

Turbolinks is a gem designed to improve page load speeds by making the browser reload only the page body elements when a tracked link is clicked.  This has the advantage of effectively force-caching all page support elements, such as CSS files, javascripts, images, etc.  Caching occurs regardless of user settings when Turbolinks is being used, provided the user is allowing Javascripts to run.

While in practice, this does drastically improve page reload speeds and reduce server network loading, it has a number of pitfalls.  Using Turbolinks effectively requires advanced awareness of how the page is going to load.  Otherwise, standard tools like Google Analytics can misbehave, users can have poor experiences as scripts fail to refresh state between page loadings, and other plugins or scripts may fail to operate as desired.

We recommend implementing Turbolinks at the end of a project, and only with careful evaluation of how Turbolinks will affect its tracked links.  Like every tool, Turbolinks has its purpose and can be incredibly beneficial when properly implemented.  Nonetheless, when used improperly, its undesirable effects can far outweigh its benefits.
[Back to steps](https://github.com/SRozick/stripeTest/blob/master/README.md#steps-to-create)

## Helpful References

## README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...

