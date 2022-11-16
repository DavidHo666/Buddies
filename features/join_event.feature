Feature: user join events functions

    I want to have an account in buddies
    Post new event with that account.

Background: users in database
    Given the following users exist:
    | username | email          | password | bio                           |
    | hhsdds   | bot1@gmail.com | bot1bot1 | I am a student at CU CS major |
    | bot2     | bot2@gmail.com | bot2bot2 | looking for new friends       |
    | bot3     | bot3@gmail.com | bot3bot3 | looking for new friends       |

    Given the following events exist:
    | event_name       | address      | start_time              | end_time                | price | description | tag          | available_spots| occupied_spots | user_id   |
    | Study Session    | NWC          | 2022-12-29 16:00:00 UTC | 2022-12-29 18:00:00 UTC |  0    |   welcome   | Academia     |   5            |   1            |     1     |
    | CS Lecture       | MUDD 527     | 2022-12-31 13:00:00 UTC | 2022-12-31 14:50:00 UTC |  30   | well known  | Academia     |   2            |   1            |     1     |
    | Halloween Parade | Time's square| 2022-12-01 12:00:00 UTC | 2022-12-01 20:00:00 UTC | 200   |  happy      | Arts&Culture |   1            |   1            |     2     |

Scenario: [sad] As a guest, join event would redirect to signin/signup
    Given I am on the home page
    When I follow "More about Study Session"
    And I press "Participate"
    Then I should be on the signin page

Scenario: As a user, can see all events posted on "events posted page"
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I follow "Events Posted"
    Then I should be on the events posted page for "bot1@gmail.com"
    And I should see "Study Session"
    And I should see "CS Lecture"
    But I should not see "Halloween Parade"

Scenario: [sad] As a user, can not join the event posted by you
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I join event "CS Lecture"
    Then I should be on the home page
    And I should see "You can't participate in your own event."
    When I follow "Events Joined"
    Then I should be on the events joined page for "bot1@gmail.com"
    And I should not see "CS Lecture"

Scenario: As a user, join a new event and can see events joined on "events joined page", ap +1 and op-1
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I join event "CS Lecture"
    Then I should be on the home page
    And I should see "You have successfully joined event CS Lecture."
    When I follow "Events Joined"
    Then I should be on the events joined page for "bot2@gmail.com"
    And I should see "CS Lecture"
    When I follow "More about CS Lecture"
    And I should see "Available Spots: 1"
    And I should see "Occupied Spots: 2"

Scenario: When join the event to make it a full party, event would not display on the home page (but can be shown on the events posted/joined page)
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I join event "Halloween Parade"
    And I should be on the home page
    But I should not see "More about Halloween Parade"
    When I follow "Events Joined"
    Then I should see "Halloween Parade"
    And I follow "More about Halloween Parade"
    Then I should see "Available Spots: 0"

Scenario: [sad] as a guest, leave event would redirect to signin/signup
    Given I am on the details page for event "Halloween Parade"
    And I press "Leave"
    Then I should be on the signin page

Scenario: [sad] can not leave the event not joined
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I follow "More about Halloween Parade"
    And I press "Leave"
    Then I should be on the home page
    And I should see "You haven't joined event Halloween Parade."

Scenario: [sad] can not leave the event created by you
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I leave event "Study Session"
    Then I should be on the home page
    And I should see "Can not leave the event created by you."

Scenario: leave a event previously joined, and the ap+1, op-1
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I join event "Halloween Parade"
    Then I should not see "More about Halloween Parade"
    When I follow "Events Joined"
    And I follow "More about Halloween Parade"
    And I press "Leave"
    Then I should be on the home page
    And I should see "You have successfully left event Halloween Parade."
    When I follow "More about Halloween Parade"
    Then I should see "Available Spots: 1"
    And I should see "Occupied Spots: 1"

Scenario: As a organizer, can see the participants of the event
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    Then I join event "Study Session"
    And I press "Sign Out"

    When I follow "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    Given I am on the details page for event "Study Session"
    And I should see "All participants:" before "bot2@gmail.com"

Scenario: As a participant, can see the participants of the event
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot3@gmail.com" and password "bot3bot3"
    Then I join event "Study Session"
    And I press "Sign Out"

    When I follow "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    Then I join event "Study Session"

    Given I am on the details page for event "Study Session"
    And I should see "All participants:" before "bot2@gmail.com"
    And I should see "All participants:" before "bot3@gmail.com"

Scenario: As a guest, can not see the participants info
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot3@gmail.com" and password "bot3bot3"
    Then I join event "Study Session"
    And I press "Sign Out"

    Given I am on the details page for event "Study Session"
    And I should not see "All participants:"
    And I should not see "bot3@gmail.com"

