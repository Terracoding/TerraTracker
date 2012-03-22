Feature: Timeslips
  So that: I am able to track my time
  As a: User
  I can: Create and edit timeslips

  Background:
    Given I am signed in as user "john@example.com"

  Scenario: Visiting the Timeslips page without a company
    Given I am on the dashboard page
    When I follow "Timeslips"
    Then I should be on the new company page
