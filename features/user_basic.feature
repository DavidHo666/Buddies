Feature: users basic functions

    I want to have an account in buddies
    Post new event with that account.

Background: users in database
    Given the following users exist:
    | username | email          | password | bio                           |
    | hhsdds   | bot1@gmail.com | bot1bot1 | I am a student at CU CS major |
    | bot2     | bot2@gmail.com | bot2bot2 | looking for new friends       |

    Given the following events exist:
    | event_name       | address      | start_time         | end_time           | price | description | tag          | available_spots| occupied_spots | user_id   |
    | Study Session    | NWC          | 2023-12-29 16:00:00| 2023-12-29 18:00:00|  0    |   welcome   | Academia     |   5            |   1            |     1     |
    | CS Lecture       | MUDD 527     | 2023-12-31 13:00:00| 2023-12-31 14:50:00|  30   | well known  | Academia     |   1            |   1            |     1     |
    | Halloween Parade | Time's square| 2023-12-01 12:00:00| 2023-12-01 20:00:00| 200   |  happy      | Arts&Culture |   9            |   1            |     2     |

Scenario: [sad] As a guest, create event would redirect to signin/signup
    Given I am on the home page
    When I follow "Add New Event"
    Then I should be on the create event page
    When I press "Save Changes"
    Then I should be on the signin page

Scenario: As a guest, create new account
    Given I am on the home page
    When I press "Sign Up"
    Then I should be on the signup page
    And I signup with email "test_user1@gmail.com" and password "123456"
    Then I should be on the home page
    And I should see "Welcome! You have signed up successfully."
    And I should see "Profile"

Scenario: [sad] As a guest, create account with existing email
    Given I am on the home page
    When I press "Sign Up"
    And I signup with email "bot1@gmail.com" and password "123456"
    Then I should see "Email has already been taken"

Scenario: As a guest, signin
    Given I am on the home page
    When I press "Sign In"
    Then I should be on the signin page
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    Then I should be on the home page
    And I should see "Signed in successfully."
    And I should see "Profile"

Scenario: As a user, signout
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    Then I press "Sign Out"
    And I should be on the logged out home page
    But I should not see "My Profile"

Scenario: As a user, edit personal information
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    When I press "Profile"
    Then I should be on the details page for user "bot1@gmail.com"
    When I follow "Edit my profile"
    Then I should be on the edit page for user "bot1@gmail.com"
    And I fill in "Username" with "bot1"
    And I press "Update User"
    Then I should be on the details page for user "bot1@gmail.com"
    And I should see "Username: bot1"

Scenario: As a user, create new event, and the event can be viewed by a guest
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add New Event"
    Then I should be on the add new event page
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "10"
    And I fill in "Occupied Spots" with "2"
    And I fill in "Price" with "0"
    And I select the time "2022-December-29 16:00" from "Start On"
    And I select the time "2022-December-29 20:00" from "End On"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "Debate session was successfully created."
    When I press "Sign Out"
    And I follow "More about Debate session"
    And I should be on the details page for event "Debate session"
    And I should see "Debate session"

Scenario: [sad] As a user, can not create event that ends before current time
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add New Event"
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "10"
    And I fill in "Occupied Spots" with "2"
    And I fill in "Price" with "0"
    And I select the time "2022-October-29 16:00" from "Start On"
    And I select the time "2022-October-29 20:00" from "End On"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "Time invalid!"
    And I should not see "Debate session"

Scenario: [sad] As a user, can not create event that has an end time earlier than start time
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add New Event"
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "10"
    And I fill in "Occupied Spots" with "2"
    And I fill in "Price" with "0"
    And I select the time "2022-October-29 23:00" from "Start On"
    And I select the time "2022-October-29 17:00" from "End On"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "Time invalid!"
    And I should not see "Debate session"

Scenario: [sad] As a user, can not create event that available spots is under 1
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add New Event"
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "0"
    And I fill in "Occupied Spots" with "2"
    And I fill in "Price" with "0"
    And I select the time "2022-December-29 13:00" from "Start On"
    And I select the time "2022-December-29 17:00" from "End On"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "At least one available spot."
    And I should not see "Debate session"

Scenario: [sad] As a user, can not create event that occupied spots is under 1
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add New Event"
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "20"
    And I fill in "Occupied Spots" with "0"
    And I fill in "Price" with "0"
    And I select the time "2022-December-29 13:00" from "Start On"
    And I select the time "2022-December-29 17:00" from "End On"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "At least one spot is occupied(by you)."
    And I should not see "Debate session"

Scenario: As a user, edit event posted by myself
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about Halloween Parade"
    And I follow "Edit"
    Then I should be on the edit page for event "Halloween Parade"
    And I fill in "Address" with "14th st, 6 Ave"
    And I press "Update Event Info"
    Then I should be on the details page for event "Halloween Parade"
    And I should see "Event Halloween Parade was successfully updated."

Scenario: [sad] As a user, can not edit event to let the end time be earlir than start time
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about Halloween Parade"
    And I follow "Edit"
    And I select the time "2022-December-29 13:00" from "Start On"
    And I select the time "2022-December-29 12:00" from "End On"
    And I press "Update Event Info"
    Then I should be on the details page for event "Halloween Parade"
    And I should see "Time invalid!"

Scenario: As a user, delete event posted by yourself
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about Halloween Parade"
    And I press "Delete"
    Then I should be on the home page
    And I should see "Event Halloween Parade was successfully deleted."

Scenario: [sad] As a user/guest, can not edit event not posted by you
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "More about Study Session"
    And I follow "Edit"
    And I press "Update Event Info"
    Then I should be on the details page for event "Study Session"
    And I should see "Event Study Session couldn't be edited by you."

Scenario: [sad] As a user/guest, can not delete event not posted by you
    Given I am on the home page
    When I follow "More about Study Session"
    And I press "Delete"
    Then I should be on the home page
    And I should see "Event Study Session couldn't be deleted by you."

Scenario: As a user, disable account
    Given I am on the home page
    When I press "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I press "Profile"
    And I press "Destroy this user"
    Then I should be on the home page
    And I should see "User was successfully destroyed."
    But I should not see "My Profile"