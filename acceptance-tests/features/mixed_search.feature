Feature: Searching by Rizzoma QL String
    As a user of Rizzoma
    I want to be able to enter a Rizzoma QL Search Request
    And find the correct topics

    Scenario: Searching for a tag
        Given a sphinx engine with records:
            | title | id  | gtags |
            | Title | 3   | tag   |
        When I search for "#tag"
        Then I should find: 
            | id |
            | 3  |


    Scenario: Searching for a tag and a user (right now assuming ptag = userid!)
        Given a sphinx engine with records:
            | title | ptags  | gtags |
            | Title | 12,14  | tag   |
        When I search for "user:12 #tag"
        Then I should find: 
            | ptags |
            | 12,14 |

    Scenario: Searching for a word
        Given a sphinx engine with records:
            | title      | id  |
            | searchword | 3   |
        When I search for "searchword"
        Then I should find: 
            | id |
            | 3  |