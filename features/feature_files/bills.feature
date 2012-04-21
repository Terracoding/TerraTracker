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
    And I should see "This is a comment"

  Scenario: I should be able to delete a bill
    Given I have a bill with comment "This is a comment" and reference "001"
    And I am on the bills page
    When I follow "Delete"
    Then I should not see "This is a comment"
    And I should not see "001"
    And I should see "The bill was successfully removed."

  Scenario: I should be able to have an unpaid bill
    Given "john" has created a bill due in the future with comment "This is a comment" and reference "001"
    When I am on the bills page
    Then I should see "No"

  Scenario: I should be able to have a paid bill
    Given I am on the bills page
    When I follow "Add Bill"
    And I fill in the following:
      | Reference         | 001                 |
      | Value             | 20.00               |
      | Comments          | This is a comment   |
    And I check "Paid"
    And I press "Create Bill"
    Then I should see "The bill was successfully created."
    And I should see "Paid"

  Scenario: I should be able to have an overdue bill
    Given "john" has created an overdue bill with comment "This is a comment" and reference "001"
    When I am on the bills page
    Then I should see "Overdue"
