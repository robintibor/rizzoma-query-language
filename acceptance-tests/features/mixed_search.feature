Feature: Searching by Rizzoma QL String With Several Conditions
    As a user of Rizzoma
    I want to be able to enter a Rizzoma QL Search Request with several conditions
    And still find the correct topics
    
Scenario: Searching for a tag and a user (right now assuming ptag = userid!)
        Given a sphinx engine with records:
            | title | ptags  | gtags |
            | Title | 12,14  | tag   |
        When I search for: user:12 #tag
        Then I should find: 
            | ptags |
            | 12,14 |

Scenario: Searching for a text and a user (right now assuming ptag = userid!)
        Given a sphinx engine with records:
            | title | ptags  |
            | love  | 12,14  |
        When I search for: user:14 love
        Then I should find:
            | ptags |
            | 12,14 |