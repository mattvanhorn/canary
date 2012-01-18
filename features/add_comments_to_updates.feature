@http://www.pivotaltracker.com/stories/new

Feature: Add comments to updates
  In order to let my manager know why I have a certain mood
  As a user
  I want to add a comment to my update

  Scenario: Add comment
    Given I have an account
      And I sign in
      And I visit the new project page
      And I create a project named "Yoyodyne website"
      And I am on the project page for "Yoyodyne website"
     When I follow "Update Mood"
      And I choose "happy" from "Mood"
      And I fill in "Comment" with "life is good"
      And I submit the update
    Then I should be on the project page for "Yoyodyne website"
     And I should see 1 happy team member
     And I should see "Current Mood: Happy"
     And I should see a comment with the text "life is good"


