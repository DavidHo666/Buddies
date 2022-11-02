Feature: event basic functions

  Search for events by tags and sorting

  Background: users in database
    Given the following users exist:
      | username | email          | password | bio                           |
      | hhsdds   | bot1@gmail.com | bot1bot1 | I am a student at CU CS major |
      | bot2     | bot2@gmail.com | bot2bot2 | looking for new friends       |

    Given the following events exist:
      | event_name       | address      | start_time              | end_time            | price | description | tag          | available_spots | occupied_spots | user_id   |
      | Study Session    | NWC          | 2022-11-29 16:00:00 UTC | 2022-11-29 18:00:00 |  0    |   welcome   | Academia     |   10            |   5            |     1     |
      | CS Lecture       | MUDD 527     | 2022-12-31 13:00:00 UTC | 2022-12-31 14:50:00 |  30   | well known  | Academia     |   60            |  45            |     2     |
      | Halloween Parade | Time's square| 2022-11-01 12:00:00 UTC | 2022-11-01 20:00:00 | 200   |  happy      | Arts&Culture |   50            |   6            |     2     |

  Scenario: Show events with specific tags
    Given I am on the home page
    And I should see all the events
    When I check "Academia"
    And I uncheck "Arts&Culture"
    And I press "Refresh"
    Then I should see "Study Session"
    But I should not see "Halloween Parade"

  Scenario: Show events with specific order
    Given I am on the home page
    When I follow "Price"
    Then I should see "Study Session" before "Halloween Parade"