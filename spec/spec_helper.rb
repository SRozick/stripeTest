require 'rubygems'
require 'spork'

#uncomment the following line to use spork with the debugger
#require 'spork/ext/ruby-debug'

Spork.prefork do
  ENV["RAILS_ENV"] ||= 'test'
  require File.expand_path("../../config/environment", __FILE__)
  require 'rspec/rails'
  require 'capybara/rspec'
  require 'capybara/poltergeist'

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

  Capybara.default_selector = :css

  Capybara.configure do |config|
    config.match = :prefer_exact
    config.ignore_hidden_elements = true
  end #Capybara.configure

  Capybara.register_driver :poltergeist do |app|
    # Test mobile browser at 320 x 480
    Capybara::Poltergeist::Driver.new app, window_size: [320, 480]
    # Test large browser at 1600 x 1200
    #Capybara::Poltergeist::Driver.new app, window_size: [1600, 1200]
  end #end Capybara.register_driver

  # Capybara.register_driver :selenium_firefox do |app|
  #   Capybara::Selenium::Driver.new(app, :browser => :firefox)
  # end

  Capybara.default_driver = :poltergeist
  Capybara.current_driver = :poltergeist
  Capybara.javascript_driver = :poltergeist

  DESKTOP_SCREENSIZE = { :width => 1280, :height => 1024 }
  MOBILE_SCREENSIZE  = { :width => 320, :height => 480 }

  RSpec.configure do |config|
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
    config.disable_monkey_patching!
    if config.files_to_run.one?
      config.default_formatter = 'doc'
    end #if files_to_run
    config.order = :random
    Kernel.srand config.seed

    config.before (:each) do |example|
      if example.metadata[:mobile]
        resize_browser_window(MOBILE_SCREENSIZE)
      else
        resize_browser_window(DESKTOP_SCREENSIZE)
      end #if metadata
    end #before each

    config.after (:all) do |example|
      Capybara.session.driver.quit
    end #after all

  end #RSpec configure do

  def resize_browser_window(size)
    Capybara.current_session.driver.resize(size[:width], size[:height])
    #Capybara.current_session.driver.browser.manage.window.resize_to(size[:width], size[:height])
  end #resize_browser_window

end #spork prefork

Spork.each_run do
  # This code will be run each time you run your specs.
#  require 'support/factory_girl'
#  require 'support/database_cleaner'
  ActiveRecord::Migration.maintain_test_schema!

end
