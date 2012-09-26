Feature: User Search
  As a user of the rizzoma query language
  I want to be able to search for users
  So that I can find topics of these users

  Scenario: Searching for users on empty sphinx
    Given a sphinx server without records
    When I search for any user
    Then I should get 0 Results

  Scenario: Searching for users that exist
    Given a sphinx server with 2 records for user 3
    When I search for user 3
    Then I should get 2 Results