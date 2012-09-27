Feature: User Search
  As a user of the rizzoma query language
  I want to be able to search for users
  So that I can find topics of these users

  Scenario: Searching for users on empty sphinx
    Given a sphinx server without records
    When I search for any user
    Then I should get 0 Results

  Scenario: Searching for users that exist
    Given the sphinx server has 3 records for user 5
    When I search for user 5
    Then I should get 3 Results