Feature: event basic functions

    Search for events by tags and sorting

Background: events in database
    Given the following events exist:
    | event_name       | address      | start_time          | end_time            | price | description | tag          | available_spots | occupied_spots |
    | Study Session    | NWC          | 2022-11-29 16:00:00 UTC | 2022-11-29 18:00:00 |  0    |   welcome   | Academia     |   10            |   5            |
    | CS Lecture       | MUDD 527     | 2022-12-31 13:00:00 UTC | 2022-12-31 14:50:00 |  30   | well known  | Academia     |   60            |  45            |
    | Halloween Parade | Time's square| 2022-11-01 12:00:00 | 2022-11-01 20:00:00 | 200   |  happy      | Arts&Culture |   50            |   6            |

Scenario: see tags and sort by title
    Given I am on the home page
    And I should see all the events
    When I check "Academia"
    And I uncheck "Arts&Culture"
    And I press "Refresh"
    Then I should see "Study Session"
    But I should not see "Halloween Parade"
    When I follow "Price"
    Then I should see "Study Session" before "CS Lecture"