Feature: Bills
  So that: I am able to manage my bills
  As a: User
  I can: Create and update bills

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"

  Scenario: I should be able to create a bill
    Given I am on the bills page
    When I follow "Add Bill"
    And I fill in the following:
      | Reference         | 001                 |
      | Value             | 20.00               |
      | Comments          | This is a comment   |
    And I press "Create Bill"
    Then I should see "The bill was successfully created."
