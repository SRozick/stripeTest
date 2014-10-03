require 'spec_helper'

RSpec.describe Widget do

  it "has a valid factory" do

    factory = FactoryGirl.create(:widget) # setup, exercise
    expect(factory).to be_valid#, lambda { factory.errors.full_messages.join("\n")
    # TODO What is `lambda { factory.errors.full_messages.join("\n")` doing here and should it be included in other factory-related tests?

  end #has a valid factory

  it "is invalid without a name" do

    widget = FactoryGirl.build(:widget, name: nil)
    expect(widget).to_not be_valid

  end # is invalid without a name

  it "is invalid without a description" do

    widget = FactoryGirl.build(:widget, description: nil)
    expect(widget).to_not be_valid

  end # is invalid without a description

  it "is invalid without a price" do

    widget = FactoryGirl.build(:widget, price: nil)
    expect(widget).to_not be_valid

  end # is invalid without a price

end #describe Widget
