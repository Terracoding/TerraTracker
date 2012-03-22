Feature: User login
  So that: I am able to use my account
  As a: User
  I can: Login to the system

  Background:
    Given I am a user with the email "user@example.com"

  Scenario: Login in to use the system as a user
    Given I am on the home page
    When I follow "Login"
    And I fill in the following:
      | Email                 | user@example.com      |
      | Password              | password              |
    And I press "Login"
    Then I should see "John, welcome to your Dashboard."
    And I should see "Signed in successfully."
