@http://www.pivotaltracker.com/story/show/21508671
Feature: Team member mood updates
  In order to give honest feedback without risking negative consequences,
  as a team member,
  I want to update my mood anonymously

  Scenario: Happy, Happy
  Given I have an account
    And I sign in
    And I visit the new project page
    And I create a project named "Yoyodyne website"
    And I am on the project page for "Yoyodyne website"
   When I follow "Update Mood"
    And I choose "happy" from "Mood"
    And I submit the update
  Then I should be on the project page for "Yoyodyne website"
   And I should see 1 happy team member
   And I should see "Current Mood: Happy"

