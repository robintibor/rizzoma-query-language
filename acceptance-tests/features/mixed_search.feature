Feature: Searching by Rizzoma QL String
    As a user of Rizzoma
    I want to be able to enter a Rizzoma QL Search Request
    And find the correct topics

    Scenario: Searching for a tag
        Given a sphinx engine with records:
            | title | ptags    |  gtags |
            | Title   | 12,14  | tag    |
        When I search for "user:12 #tag"
        Then I should find: 
            | ptags   |
            | 12,14   | 

