Feature: Searching by Rizzoma QL String For Exact Phrases
    As a user of Rizzoma
    I want to be able to enter search for exact phrases
    And find the correct topics

    Scenario: Searching for an exact phrase
        Given a sphinx engine with records:
            | content | id  |
            | I love you | 2   |
        When I search for: "I love you"
        Then I should find:
            | id |
            | 2  |

    Scenario: Searching for a non-existing exact phrase
        Given a sphinx engine with records:
            | content | id  |
            | I love you | 2   |
        When I search for: "I you"
        Then I should get 0 Results

    Scenario: Searching for an exact phrase and a  word
        Given a sphinx engine with records:
            | content | id  |
            | I love you crazy angel | 2 |
        When I search for: "I love you" angel
        Then I should find:
            | id |
            | 2  |