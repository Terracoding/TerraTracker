Feature: Company creation
  So that: I am able to create a company
  As a: User
  I can: Register my company

  Background:
    Given I am signed in as user "john@example.com"
    
  Scenario: I should be redirected to create a new company when I visit Company without one
    Given I am on the dashboard page
    When I follow "Company"
    Then I should see "Create Your Company"

  Scenario: Signing up to use the system as a user
    Given I am on the dashboard page
    When I follow "Company"
    And I fill in the following:
      | Company Name            | Test Company        |
      | Registration Number     | 1001                |
    And I press "Create company"
    Then I should see "Company Overview"
    And I should see "The company Test Company was successfully created."
