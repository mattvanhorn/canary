@http://www.pivotaltracker.com/story/show/21510083
Feature: User Sign Up
  In order to have my information applied to a project
  as a project member
  I want to sign up

  Scenario: Sign Up link
  Given I am not signed in

  When I visit the homepage
   And I follow "Sign Up"

  Then I should be on the sign-up page

  Scenario: Sign Up
  Given I am not signed in

  When I visit the sign-up page
   And I submit my valid registration information

  Then I should be on the homepage
   And I should see a link to the update status page
   And I should see a link to the sign-out page

