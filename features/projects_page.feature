@http://www.pivotaltracker.com/stories/new
@javascript

Feature: Projects page
  In order to see how happy the community is
  As a user
  I want to see all projects

  Scenario: Guest View
    Given 3 projects
    When I visit the projects page
    Then I should see exactly 3 projects
    When I click on "Mood"
    Then I should see exactly 3 projects




