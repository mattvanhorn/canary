Feature: Send project link
  In order to get my boss to see the team's morale
  As a team member
  I want to send him an anonymous link to the project.
  
  Given the following project:
  And the following user:
  And I am logged in as that user
  When I go to the project page for that project
  And I fill in "email" with "pointyhair@example.com"
  And I click on "email anonymous link"
  Then "pointyhair@example.com" should receive an email
  When they open the email
  And they click the first link in the email
  Then they should be on the project page
  And they should see "sign up"
  And they should not see "update mood"
