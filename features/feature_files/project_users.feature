Feature: Project Users
  So that: Users can be added to specific projects
  As a: User
  I can: Create project users

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
    And I have a company user "jane@example.com"
    And I have a project "test project"

  Scenario: Create a new project user
    Given I am on the projects page
    When I follow "Show"
    When I follow "Add Project User"
    And I select "Jane Doe" from "User"
    And I press "Add User"
    Then I should see "Jane was successfully added to the project."
