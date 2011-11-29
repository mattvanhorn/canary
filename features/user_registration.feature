@http://www.pivotaltracker.com/story/show/21510083
Feature: User Registration
  In order to have my information applied to a project
  as a project member
  I want to register

  Scenario: Registration link
  Given I am not logged in
  
  When I visit the homepage
   And I follow "Register"
  
  Then I should be on the registration page

  Scenario: Registration
  Given I am not logged in

  When I visit the registration page
   And I submit my valid registration information

  Then I should be on the homepage
   And I should see a link to the update status page
   And I should see a link to the logout page
