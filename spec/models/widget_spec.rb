require 'spec_helper'

# Testing Style Guide
#   Use the following guidelines and references to write effective tests

#   Each example should expect one thing
#   Each example should be explicit (use "it" to make it easier to read)
#   Each example description begins with a verb (as opposed to 'should', for ease of reading output)
#   - Taken from Everyday Rails: How I Learned to Test My Rails Applications,
#     by Aaron Sumner, posted 19March2012 at http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html

#   Use the negative form to indicate the object may have one or more of item, so:
#     "is invalid without..." indicates the object must have at least one and may have more than one
#     "has" indicates the object has one and only one

#   Use an open line break between tests
#   Use four-phase testing structure (setup, exercise, verify, teardown) (Dan Croak, Thoughtbot, 28 Sept 2012. http://robots.thoughtbot.com/four-phase-test)

RSpec.describe Widget do

  it "has a valid factory" do

    factory = FactoryGirl.create(:widget) #setup

    if factory.respond_to?(:valid?) #exercise

      expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") } #verify
    end #if factory.respond_to

  end #has a valid factory

  it "is invalid without a name"
  it "is invalid without a description"
  it "is invalid without a price"
end #describe Widget