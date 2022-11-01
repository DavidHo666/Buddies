Feature: users basic functions

    I want to have an account in buddies 
    Post new event with that account.   

Background: users in database
    Given the following users exist:
    | username | email          | password | bio                           | 
    | hhsdds   | bot1@gmail.com | bot1bot1 | I am a student at CU CS major |
    | bot2     | bot2@gmail.com | bot2bot2 | looking for new friends       |

Scenario: add movie fail, create account, logout
    Given I am on the home page
    When I follow "Add new event"
    Then I should be on the create event page
    When I press "Save Changes"
    Then I should be on the signin page
    Then I follow "Sign up"
    Then I should be on the signup page
    And I signup with email "test_user1@gmail.com" and password "123456"
    Then I should see "Welcome! You have signed up successfully."
    And I should be on the home page
    And I should see "My Profile"
    Then I press "Sign Out"
    But I should not see "My Profile"

Scenario: login and edit personal information
    Given I am on the home page
    When I follow "Sign In"
    Then I should be on the signin page
    And I signin with email "bot1@gmail.com" and password "bot1bot1"
    Then I should see "Signed in successfully."
    When I follow "My Profile"
    Then I should be on the details page for user "bot1@gmail.com"
    When I follow "Edit this user"
    Then I should be on the edit page for "bot1@gmail.com"
    And I fill in "Username" with "bot1"
    And I fill in "Password" with "bot1bot1"
    And I press "Update User"
    Then I should be on the details page for user "bot1@gmail.com"
    And I should see "Username: bot1"

Scenario: post new event
    Given I am on the home page
    When I follow "Sign In"
    And I signin with email "bot2@gmail.com" and password "bot2bot2"
    When I follow "Add new event"
    Then I should be on the add new event page
    And I fill in "Event Name" with "Debate session"
    And I fill in "Address" with "MUDD 627"
    And I fill in "Available Spots" with "10"
    And I fill in "Occupied Spots" with "2"
    And I fill in "Price" with "0"
    And I select "Academia" from "tag"
    When I press "Save Changes"
    Then I should be on the home page
    And I should see "Debate session was successfully created."
    When I press "Sign Out"
    And I follow "More about Debate session"
    And I should be on the details page for event "Debate session"
    And I should see "Debate session"






    


