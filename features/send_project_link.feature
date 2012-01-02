@http://pivotaltracker.com/stories/new
Feature: Send project link
  In order to get my boss to see the team's morale
  As a team member
  I want to send him an anonymous link to the project.

  Scenario: Sending a link to project page
    Given the following project:
      | name | Foobar |
    And that project has 1 user
    And I sign in as that user
    When I visit the project page for "Foobar"
    And I fill in "Email" with "pointyhair@example.com"
    And I click on "Send Link"
    And I sign out
    Then "pointyhair@example.com" should receive an email
    When they open the email
    And they click the first link in the email
    Then they should be on the project page for "Foobar"
    And they should see "Sign Up"
    And they should not see "Update Mood"
