@http://www.pivotaltracker.com/story/show/21510183
Feature: Create Project
  In order to gauge the mood of my team
  as a team leader
  I want to create a project

  Background:
  Given I have an account
     And I sign in
     
  Scenario: New Project Link
    When I visit the projects page
    Then I should see a link to the new project page
  
  Scenario: Create a project
    When I visit the new project page
     And I create a project named "Yoyodyne website"
    Then I should be on the project page for "Yoyodyne website"
     And I should see "Yoyodyne website"
     And I should see 1 member
     And I should see a link to the invite members page for "Yoyodyne website"
  
  Scenario: Create a project without a name
    When I visit the new project page
     And I create a project without a name
    Then I should be on the projects page
     And I should see "can't be blank" within the project name input area
