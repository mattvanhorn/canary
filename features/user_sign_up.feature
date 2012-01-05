@http://www.pivotaltracker.com/story/show/21510083
Feature: User Sign Up
  In order to have my information applied to a project
  as a project member
  I want to sign up

  Background:
    Given I am not signed in

  Scenario: Sign Up link
    When I visit the homepage
     And I follow "Sign Up"
    Then I should be on the sign-up page

  Scenario: Sign Up
    When I visit the sign-up page
     And I submit my valid registration information
    Then I should be on the new project page
     And I should see a link to the sign-out page

  Scenario: Sign Up without email
   When I visit the sign-up page
    And I submit my registration information without an email
   Then I should be on the failed sign-up page
    And I should see "Email can't be blank"

  Scenario: Sign Up without password
   When I visit the sign-up page
    And I submit my registration information without a password
   Then I should be on the failed sign-up page
    And I should see "Password can't be blank"

  Scenario: Sign Up without password confirmation
   When I visit the sign-up page
    And I submit my registration information without a password confirmation
   Then I should be on the failed sign-up page
    And I should see "Confirmation can't be blank"

  Scenario: Sign Up without password matching confirmation
   When I visit the sign-up page
    And I submit my registration information without password matching confirmation
   Then I should be on the failed sign-up page
    And I should see "Password doesn't match confirmation"


