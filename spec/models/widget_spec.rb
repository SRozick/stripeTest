require 'spec_helper'

RSpec.describe Widget do

  it "has a valid factory" do

    factory = FactoryGirl.create(:widget) #setup
    # if factory.respond_to?(:valid?)
    expect(factory).to be_valid, lambda { factory.errors.full_messages.join("\n") } #verify
    # end #if factory.respond_to

  end #has a valid factory

  it "is invalid without a name"
  it "is invalid without a description"
  it "is invalid without a price"
end #describe Widget