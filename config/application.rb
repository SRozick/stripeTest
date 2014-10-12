require File.expand_path('../boot', __FILE__)
require 'rails/all'
Bundler.require(*Rails.groups)

module StripeTest
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    config.time_zone = 'Eastern Time (US & Canada)'

    config.generators do |g|
        g.test_framework :rspec,
            :fixtures =>            true,   # whether to generate a fixture for each model
            :view_specs =>          true,  # whether to generate view_specs
            :helper_specs =>        false,  # whether to generate a helper spec for each controller
            :routing_specs =>       true,  # whether to generate a spec for config/routes.rb
            :controller_specs =>    true,   # whether to generate specs for each controller
            :request_specs =>       true    # whether to generate request specs for action chains
        g.fixture_replacement :factory_girl, :dir => "spec/factories"
    end #config.generators do

  end #Application class
end #StripeTest module
