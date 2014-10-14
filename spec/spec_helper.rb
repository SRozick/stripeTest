require 'rubygems'
require 'spork'

#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  # Add additional requires below this line. Rails is not loaded until this point!
# The Spork.prefork block is run only once when the spork server is started.
# You typically want to place most of your (slow) initializer code in here, in
# particular, require'ing any 3rd-party gems that you don't normally modify
# during development.
  if $LOADED_FEATURES.grep(/spec\/spec_helper\.rb/).any?
    begin
      raise "foo"
    rescue => e
      puts <<-MSG
    ===================================================
    It looks like spec_helper.rb has been loaded
    multiple times. Normalize the require to:

      require "spec/spec_helper"

    Things like File.join and File.expand_path will
    cause it to be loaded multiple times.

    Loaded this time from:

      #{e.backtrace.join("\n    ")}
    ===================================================
      MSG
    end # begin
  end #if

  RSpec.configure do |config|
    config.fixture_path = "#{::Rails.root}/spec/fixtures"
    # Transactional fixtures must be disabled for database cleaner to work
    config.use_transactional_fixtures = false

    config.infer_spec_type_from_file_location!
    config.expect_with :rspec do |expectations|
      expectations.include_chain_clauses_in_custom_matcher_descriptions = true
      expectations.syntax = :expect
    end

    config.mock_with :rspec do |mocks|
      mocks.verify_partial_doubles = true
    end

    config.filter_run :focus
    config.run_all_when_everything_filtered = true
    # config.render_views

    config.disable_monkey_patching!

    if config.files_to_run.one?
      config.default_formatter = 'doc'
    end

    config.order = :random

    Kernel.srand config.seed

  end

end #spork prefork

Spork.each_run do
  # This code will be run each time you run your specs.
#  require 'support/factory_girl'
#  require 'support/database_cleaner'
  ActiveRecord::Migration.maintain_test_schema!

end
