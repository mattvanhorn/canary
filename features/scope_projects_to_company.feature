@http://www.pivotaltracker.com/story/show/22175933
Feature: Scope projects to company
  In order to make it easier to find/name my project
  as a team member
  I want to link projects to a company

    Background:
    Given I have an account
       And I sign in

    Scenario: Create a project
      When I visit the new project page
       And I create the following project:
         |name| Yoyodyne website|
         |company| Acme Products|
      Then I should be on my projects page
       And I should see "Acme Products"
       And I should see "Yoyodyne website"
       And I should see one member
       And I should see a link to the invite members page for "Yoyodyne website"
