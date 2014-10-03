# Testing Style Guide

###   Use the following guidelines and references to write effective tests:

#### Describe examples clearly

  * Each example should expect one thing

  * Each example should be explicit (use "it" to make it easier to read)

  * Each example description begins with a verb (as opposed to 'should', for ease of reading output)

      Taken from Everyday Rails: How I Learned to Test My Rails Applications,
      by Aaron Sumner, posted 19March2012 at http://everydayrails.com/2012/03/19/testing-series-rspec-models-factory-girl.html


#### Use the negative form to indicate the object may have one or more of item, so:

  * "is invalid without..." indicates the object must have at least one and may have more than one

  *"has" indicates the object has one and only one

#### Use an open line break between tests

Use four-phase testing structure:

  * Setup: declare variables, classes, objects, and/or methods required for test
  * Exercise: save any objects and execute any methods required to create the test conditions (may not be required on all tests)
  * Verify: conduct tests against the conditions now established
  * Teardown: restore the system to its pre-test state (normally handled automatically)

    Taken from Four Phase Tests
    by Dan Croak, Thoughtbot, 28 Sept 2012. http://robots.thoughtbot.com/four-phase-test
