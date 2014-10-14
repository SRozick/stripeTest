# A sample Guardfile
# More info at https://github.com/guard/guard#readme

# NOTE, Spork must be 'fixed' per notes here
# https://github.com/manafire/spork/blob/38c79dcedb246daacbadb9f18d09f50cc837de51/lib/spork/test_framework/rspec.rb#
# and
# http://stackoverflow.com/a/24085168/3780876
guard 'spork', :cucumber_env => { 'RAILS_ENV' => 'test' }, :rspec_env => { 'RAILS_ENV' => 'test' } do
  watch('config/application.rb')
  watch('config/environment.rb')
  watch('config/config.yml')
  watch('config/environments/test.rb')
  watch(%r{^config/initializers/.+\.rb$})
  watch('Gemfile.lock')
  watch('spec/spec_helper.rb') { :rspec }
  # watch('test/test_helper.rb') { :test_unit }
  watch(%r{features/support/}) { :cucumber }
end

# Note: The -drb option for rspec is required for spork to run properly
guard :rspec, cmd: 'bundle exec rspec --drb' do
  # Watch these files based on REGEX                   # And TEST the files in these folders if the watched files change
  watch(%r{^spec/.+_spec\.rb$})
  watch(%r{^lib/(.+)\.rb$})                                       { |m| "spec/lib/#{m[1]}_spec.rb" }
  watch('spec/spec_helper.rb')                                    { "spec" }
  watch('config/config.yml')                                      { "spec" }
  # Rails example
  watch(%r{^app/(.+)\.rb$})                                       { |m| "spec/#{m[1]}_spec.rb" }
  watch(%r{^app/(.*)(\.erb|\.haml|\.slim)$})                      { |m| "spec/#{m[1]}#{m[2]}_spec.rb" }
  watch(%r{^app/controllers/(.+)_(controller)\.rb$})              { |m| ["spec/routing/#{m[1]}_routing_spec.rb", "spec/#{m[2]}s/#{m[1]}_#{m[2]}_spec.rb", "spec/acceptance/#{m[1]}_spec.rb"] }
  watch(%r{^spec/support/(.+)\.rb$})                              { "spec" }
  watch('config/routes.rb')                                       { "spec/routing" }
  watch('app/controllers/application_controller.rb')              { "spec/controllers" }
  watch('spec/rails_helper.rb')                                   { "spec" }
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})                 { |m| "spec/views/#{m[1]}_spec.rb" }
  watch(%r{^app/views/layouts/application.html\.(erb|haml|slim)$})     { "spec/views" }
  watch(%r{^app/views/layouts/application.html\.(erb|haml|slim)$})     { "spec/features" }
  watch(%r{^app/(.+)\.rb$})                                       { |m| "spec/features/#{m[1]}_spec.rb" }
  watch(%r{^app/views/.*\.(erb|haml|slim)$})                      { "spec/features" }

  # Run factories on modifications
  watch(%r{^spec/factories/(.+)\.rb$})                            { "spec" }

  # Capybara features specs
  watch(%r{^app/views/(.+)/.*\.(erb|haml|slim)$})                 { |m| "spec/features/#{m[1]}_spec.rb" }

  # Turnip features and steps
  watch(%r{^spec/acceptance/(.+)\.feature$})
  watch(%r{^spec/acceptance/steps/(.+)_steps\.rb$})               { |m| Dir[File.join("**/#{m[1]}.feature")][0] || 'spec/acceptance' }
end

# LiveReload gem will automatically reload web pages on saving into watched folders/files
guard 'livereload' do
  watch(%r{app/views/.+\.(erb|haml|slim)$})
  watch(%r{app/helpers/.+\.rb})
  watch(%r{public/.+\.(css|js|html)})
  watch(%r{config/locales/.+\.yml})
  # Rails Assets Pipeline
  watch(%r{(app|vendor)(/assets/\w+/(.+\.(css|js|html|png|jpg))).*}) { |m| "/assets/#{m[3]}" }
end
