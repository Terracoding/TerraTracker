Feature: Project Users
  So that: Users can be added to specific projects
  As a: User
  I can: Create project users

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
    And I have a company user "Jane"
    And I have a project "test project"

  Scenario: Create a new project user
    Given I am on the projects page
    When I follow "Show"
    And I follow "Add Project User"
    And I select "Jane Doe" from "User"
    And I press "Add User"
    Then I should see "Jane was successfully added to the project."

  Scenario: Remove project user
    Given I have the project user "Jane"
    And I am on the projects page
    When I follow "Show"
    And I follow "Remove"
    Then I should see "The user was successfully removed."
    And I should not see "Jane"

  Scenario: Creating duplicate users
    Given I have the project user "Jane"
    When I am on the projects page
    And I follow "Show"
    And I follow "Add Project User"
    And I select "Jane Doe" from "User"
    And I press "Add User"
    Then I should not see "Jane was successfully added to the project."
