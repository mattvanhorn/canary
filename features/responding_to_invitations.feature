@http://www.pivotaltracker.com/story/show/21510279
Feature: Responding To Invitations
  In order to give feedback on a project
  As a project member
  I want to accept an invitation
  
  # default account email: alice@example.com
  Background:
    Given no emails have been sent
      And I have an account
      And I sign in
      And I visit the new project page
      And I create a project named "Yoyodyne website"
      And I invite "bob@example.com" to the project "Yoyodyne website"
      And "bob@example.com" should receive an email with subject "Invitation"
      And I sign out
      
  Scenario: Accepting an invitation
  Given "bob@example.com" should have an email
   When they open the email
    And they click the first link in the email
   Then they should be on the accept invitation page
   When they submit "password" as their new password
   Then they should be on the project page for "Yoyodyne website"
    And they should see "Update Status"
