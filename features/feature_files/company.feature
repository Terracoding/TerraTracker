Feature: Company
  So that: I am able to create a company
  As a: User
  I can: Register my company

  Background:
    Given I am signed in as user "john@example.com"
    
  Scenario: I should be redirected to create a new company when I visit Company without one
    Given I am on the dashboard page
    When I follow "Company"
    Then I should see "Create Your Company"

  Scenario: I should be able to create a company
    Given I am on the dashboard page
    When I follow "Company"
    And I fill in the following:
      | Company Name            | Test Company        |
      | Registration Number     | 1001                |
    And I press "Create company"
    Then I should see "Company Overview"
    And I should see "The company Test Company was successfully created."
  
  Scenario: I should be able to edit a company
    Given I own the company "Test Company"
    When I follow "Edit Company"
    And I fill in the following:
      | Company Name            | Updated Company     |
      | Registration Number     | 1002                |
    And I press "Update"
    Then I should see "The company Updated Company was successfully updated."
    And I should see "1002"
