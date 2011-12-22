@http://www.pivotaltracker.com/story/show/22175969

Feature: See my projects
  In order to get to my projects quickly
  as a team member
  I want to see a My Projects page

    Background:
      Given I have an account
        And I sign in
        And I have a project named "Foobar"
        
    @javascript 
    Scenario:
      Given I am on the home page
       When I click on "My Projects"
       Then I should be on my projects page
        And I should see "Foobar"
