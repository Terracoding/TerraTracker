Feature: Accounts
  So that: I am able to modify my account
  As a: User
  I can: Change my password and details

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"

  Scenario: I should be able to edit my account name
    Given I am on the accounts page
    And I follow "Edit Account"
    And I fill in the following:
      | First Name        | Foo           |
      | Last Name         | Bar           |
      | Current password  | password      |
    And I press "Update"
    Then I should see "You updated your account successfully."
    And I should see "Foo Bar"
