Feature: User registration
  So that: I am able to create an account
  As a: User
  I can: Register to use the system

  Background:
    Given I am not logged in

  Scenario: Signing up to use the system as a user
    Given I am on the home page
    When I follow "Try For Free"
    And I fill in the following:
      | First Name            | John                  |
      | Last Name             | Doe                   |
      | Email                 | john@example.com      |
      | Password              | password              |
      | Password confirmation | password              |
    And I press "Create account"
    Then I should see "You have not set up your company."
    And I should see "John, welcome to your Dashboard."
