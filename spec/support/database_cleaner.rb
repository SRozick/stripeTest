# this code is courtesy of Avdi Grimm, Configuring database_cleaner with
# Rails, RSpec, Capybara, and Selenium.  Posted 31Aug2012.  Retrieved 04Oct2014
# from
# http://devblog.avdi.org/2012/08/31/configuring-database_cleaner-with-rails-rspec-capybara-and-selenium/

# Note that for this to work properly, config.use_transactional_fixtures
# must be set to =false in spec/rails_helper.rb
RSpec.configure do |config|

  # cleans database before tests
  config.before(:suite) do
    DatabaseCleaner.clean_with(:truncation)
  end

  # sets default database cleaner method to transaction
  config.before(:each) do
    DatabaseCleaner.strategy = :transaction
  end

  # overrides default database cleaner method when :js => true,
  # because Capybara and Selenium fire up a test server for these test
  # types
  config.before(:each, :js => true) do
    DatabaseCleaner.strategy = :truncation
  end

  # Runs database cleaner at the beginning and end of each test
  config.before(:each) do
    DatabaseCleaner.start
  end
  config.after(:each) do
    DatabaseCleaner.clean
  end

end
