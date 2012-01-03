@http://www.pivotaltracker/stories/new
Feature: Team over time chart
  In order to spot morale issues
  As a team member
  I want to see the last 7 days of mood updates

  Scenario: One member
    Given the following project:
      | name | Foobar |
    And that project has 1 member
    And that member has the following mood updates:
    | mood_score | updated_at |
    | 3          | 2012-01-01 12:00:00 |
    | 3          | 2012-01-02 12:00:00 |
    | 2          | 2012-01-03 12:00:00 |
    | 1          | 2012-01-04 12:00:00 |
    | 2          | 2012-01-05 12:00:00 |
    | 3          | 2012-01-06 12:00:00 |
    | 3          | 2012-01-07 12:00:00 |

    When I visit the project page for "Foobar"

    Then show me the page
