require 'faker'

FactoryGirl.define do

  # Create a valid widget using Faker
  factory :widget do |f|
    f.name{ Faker::Commerce.product_name }
    f.description{ Faker::Lorem.paragraph }
    f.price{ Faker::Commerce.price }
  end #factory widget

  factory :invalid_widget, parent: :widget do |f|
    f.name nil
  end #

end #FactoryGirl
