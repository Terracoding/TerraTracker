Feature: Company Users
  So that: Users can be added to the company
  As a: User
  I can: Create company users

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"

  Scenario: Create a new company user
    Given I am on the company page
    When I follow "Add User"
    And I fill in the following:
      | First Name            | Jane                  |
      | Last Name             | Doe                   |
      | Email                 | jane@example.com      |
      | Password              | password              |
    And I press "Create Company User"
    Then I should see "You have successfully added Jane Doe to your company."
    
  Scenario: Delete a new company user
    Given I am on the company page
    And I have a company user "jane@example.com"
    When I follow "Delete"
    Then I should see "The user was successfully removed."
