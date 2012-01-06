@http://www.pivotaltracker.com/story/show/22175969
Feature: See my projects
  In order to get to my projects quickly
  as a team member
  I want to see a My Projects page

    Background:
      Given 3 projects
        And 1 user
        And that user has 1 project
        And I sign in

    @javascript
    Scenario:
      Given I am on the home page
       When I click on "Projects"
       Then I should be on the projects page
       And I should see exactly 1 project
       When I click on "All"
       Then I should see exactly 4 projects
