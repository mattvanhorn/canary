@http://www.pivotaltracker.com/story/show/21508791
Feature: User Sign In
  In order to update my status
  As a user
  I want to sign in to my account

  Background:
    Given I am not signed in
  
  Scenario: Cannot update while logged out
    When I visit the homepage
    Then I should not see a link to the update status page
  
  Scenario: home page log in link
    Given I have an account
    When I visit the homepage
    Then I should see a link to the sign-in page

  Scenario: Signing in
    Given I have an account
    When I sign in
    Then I should be on the homepage
     And I should see a link to the update status page
     And I should see a link to the sign-out page
   
  Scenario: Signing in with no credentials
    When I sign in with no credentials
    Then I should be on the sign-in page
     And I should see "How do you expect me to sign you in with no credentials?"
   
  Scenario: Signing in with no password
    When I sign in with no password
    Then I should be on the sign-in page
     And I should see "You must provide a password"

  Scenario: Signing in with no email
    When I sign in with no email
    Then I should be on the sign-in page
     And I should see "You must provide an email address"

  Scenario: Signing in with bad credentials
    When I sign in with bad credentials
    Then I should be on the sign-in page
     And I should see "Your email address or password is incorrect"