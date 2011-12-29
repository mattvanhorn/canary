@http://www.pivotaltracker.com/story/show/21508561
Feature: Display Team Overall Mood
  In order to keep my team happy and productive,
  as a team leader,
  I want to know the general mood of my team.

  Scenario: All happy
  Given the following project:
    | name | Foobar |
  And that project has 5 happy members
  When I visit the project page for "Foobar"
  Then I should see "Mood: Happy"

  Scenario: All Frustrated
  Given the following project:
    | name | Foobar |
  And that project has 5 frustrated members
  When I visit the project page for "Foobar"
  Then I should see "Mood: Frustrated"

  Scenario: Average Mood: Satisfied
  Given the following project:
    | name | Foobar |
  And that project has 4 happy members  
  And that project has 2 frustrated members
  When I visit the project page for "Foobar"
  Then I should see "Mood: Satisfied"
  
  Scenario: Average Mood: Bored
  Given the following project:
    | name | Foobar |
  And that project has 2 happy members  
  And that project has 4 frustrated members
  When I visit the project page for "Foobar"
  Then I should see "Mood: Bored"
  
