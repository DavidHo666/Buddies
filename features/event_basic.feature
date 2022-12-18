Feature: event basic functions

  Search for events by tags and sorting

  Background: users in database
    Given the following users exist:
      | username | email          | password | bio                           |
      | hhsdds   | bot1@gmail.com | bot1bot1 | I am a student at CU CS major |
      | bot2     | bot2@gmail.com | bot2bot2 | looking for new friends       |

    Given the following events exist:
      | event_name       | address      | start_time         | end_time           | price | description | tag          | available_spots | occupied_spots | user_id   |
      | Study Session    | NWC          | 2023-12-29 16:00:00| 2023-12-29 18:00:00|  0    |   welcome   | Academia     |   23            |   4            |     1     |
      | CS Lecture       | Columbia University     | 2023-12-31 13:00:00| 2023-12-31 14:50:00|  30   | well known  | Academia     |   2             |  44            |     2     |
      | Halloween Parade | Time's square| 2022-12-01 12:00:00| 2022-12-01 20:00:00| 200   |  happy      | Arts&Culture |   1             |   1            |     2     |

  Scenario: Show events with specific tags
    Given I am on the home page
    And I should see all the valid events
    When I check "Academia"
    And I uncheck "Arts&Culture"
    And I press "Refresh"
    Then I should see "Study Session"
    But I should not see "Halloween Parade"

  Scenario: Show events with specific order
    Given I am on the home page
    When I follow "Price"
    Then I should see "Study Session" before "CS Lecture"

  Scenario: The event with end time earlier than now would not display on the home page (but can be shown on the events posted/joined page)
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    And I join event "CS Lecture"
    And I press "Sign Out"

    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about CS Lecture"
    And I follow "Edit"
    And I select the time "2022-October-29 17:00" from "Start On"
    And I select the time "2022-October-29 20:00" from "End On"
    When I press "Update Event Info"
    Then I am on the home page
    And I should not see "CS Lecture"
    When I press "Posted"
    But I should see "CS Lecture"
    And I press "Sign Out"

    When I press "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    And I press "Joined"
    And I should see "CS Lecture"

  Scenario: The event with available spots lower than 1 would bot be displayed on the home page
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about CS Lecture"
    And I follow "Edit"
    And I fill in "Available Spots" with "0"
    And I press "Update Event Info"
    Then I should not see "More about CS Lecture"
    When I press "Posted"
    And I should see "CS Lecture"

  Scenario: As a user/guest, can see the organizer of the event on its detail page
    Given I am on the details page for event "Study Session"
    Then I should see "Organizer: bot1@gmail.com"


  Scenario: I can search for events by event name
    Given I am on the home page
    When I search event name "CS Lecture"
    And I should see "CS Lecture"

  Scenario: I can search for events by event date
    Given I am on the home page
    When I search event date "2023-12-31"
    And I should see "CS Lecture"

#  Scenario: As a user, can see a pin on map
#    Given I am on the home page
#    And I expect a Google map to load