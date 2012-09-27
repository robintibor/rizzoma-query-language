Feature: Searching by Rizzoma QL String With Stemming and Exact Matches
    As a user of Rizzoma
    I want to be able to search for morphologically similar words and exact words
    And find the correct topics

    Scenario: Searching for a morphologically similar word
        Given a sphinx engine with records:
            | title   | id |
            | running | 2  |
        When I search for: run
        Then I should find:
            | id |
            | 2  |

    Scenario: Searching for an exakt word
        Given a sphinx engine with records:
            | title   | id |
            | running | 3  |
        When I search for: =run
        Then I should get 0 Results

    Scenario: Searching for a morphologically similar word and an exact word
        Given a sphinx engine with records:
            | title   | id |
            | running spying | 2  |
        When I search for: =running spy
        Then I should find:
            | id |
            | 2  |
