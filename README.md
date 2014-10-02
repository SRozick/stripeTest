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

### Steps to create
1. `$ rails new <project_name> --database=postgresql`
1. `$ cd <project_name>`
1. `$ subl .`
1. `$ rvm gemset use <rails_ver>@<project_name> --create
1. Edit Gemfile
  1. All of the following steps can be implemented using a template or by modifying the `rails new` generator process.
  1. Comment out turbolinks.  [Why?][1] Argument: Turbolinks can cause issues in page loading and javascript behavior.  If implemented, it should be implemented at the end of the project rather than the beginning.
  1. Replace rubyracer with nodejs.  Argument: nodejs is expected to run faster and cleaner in most environments.
  1. Remove remaining comments (to avoid clutter)
1. Edit config/database.yml
  1. Under `default:`, add `username:<local_username>`
  1. Under `development:` and under `test:`, remove or comment out `username:<value>`

### Troubleshooting

### Other Useful Notes

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
