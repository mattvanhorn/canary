@http://www.pivotaltracker.com/story/show/21508561
Feature: Display Team Overall Mood
  In order to keep my team happy and productive,
  as a team leader,
  I want to know the general mood of my team.

  Scenario: All happy
  Given there is 1 project with 5 members
  And all the project members are happy
  When I visit the team overview page
  Then I should see "Mood: Happy"

  Scenario: Mixed Emotions
  Given there is 1 project with 5 members
  And 3 project members are happy
  And 2 project members are frustrated
  When I visit the team overview page
  Then I should see "Mood: Mixed"

  Scenario: All Frustrated
  Given there is 1 project with 5 members
  And all the project members are frustrated
  When I visit the team overview page
  Then I should see "Mood: Frustrated"
