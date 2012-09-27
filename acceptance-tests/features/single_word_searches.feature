Feature: Searching by Rizzoma QL String With One Condition
    As a user of Rizzoma
    I want to be able to enter a simple Rizzoma QL Search Request with just one condition
    And find the correct topics

    Scenario: Searching for a tag
        Given a sphinx engine with records:
            | title | id  | gtags |
            | Title | 3   | tag   |
        When I search for: #tag
        Then I should find: 
            | id |
            | 3  |
    
    Scenario: Searching for a word in the title
        Given a sphinx engine with records:
            | title      | id  |
            | searchword | 3   |
        When I search for: searchword
        Then I should find:
            | id |
            | 3  |

    Scenario: Searching for a word in the title of one record
        Given a sphinx engine with records:
            | title         | id  |
            | differentword | 1   |
            | searchword    | 2   |
        When I search for: searchword
        Then I should find:
            | id |
            | 2  |