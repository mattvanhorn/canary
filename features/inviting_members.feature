@http://www.pivotaltracker.com/story/show/21510269
Feature: Inviting Members
  In order to get useful feedback from my team
  As a team leader
  I want to invite my team members to the project

  # default account email: alice@example.com
  Background:
    Given I have an account
      And I sign in
      And I visit the new project page
      And I create a project named "Yoyodyne website"

  Scenario: Inviting users
    When I invite "bob@example.com" to the project "Yoyodyne website"
    Then "bob@example.com" should receive an email with subject "Invitation"
     And I should be on the project page for "Yoyodyne website"
    When they open the email
    Then they should see "Yoyodyne website" in the email body
     And they should see the email delivered from "alice@example.com"

