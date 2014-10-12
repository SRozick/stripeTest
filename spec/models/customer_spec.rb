require 'spec_helper'

  # User is a person who uses site services

  # Minimize information required of User (Usability issues)
  # Maximize service availability without registration
  # Maximize consistency of site performance without registration
  #   ie, session and cookie control maintain consistency
  #   translate session history and cookie control to user at registration

  #  User is supported by
  # => Payment methods (0 or more)
        # => Paypal (0 or more)
        # => Credit Card (0 or more)
        # => ACH/ Check (0 or more)
        # => Credit on account (0 or 1)
  # => Multiple emails (one or more)
  # => Multiple addresses (0 or more)
        # => Shipping address (0 or more)
        # => Billing address (0 or more)
  # => Multiple phone numbers (0 or more)
  # => Multiple login/ validation methods (1 or more)
        # => Facebook
        # => LinkedIn
        # => Twitter
        # => Google Plus
        # => Direct (email, password)

# RSpec.describe User do

# it "has a valid factory"

# it "is valid with a first name, last name, and email address"

# it "is invalid without a first name"

# it "is invalid without a last name"

# it "is invalid without an email address"

# it "is invalid with a duplicate email address"

# it "returns User's full name as a string"

# end #User
