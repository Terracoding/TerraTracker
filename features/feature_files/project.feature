Feature: Project
  So that: I am able to create projects
  As a: User
  I can: Create and manage projects

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"

  Scenario: I should be able to create a project
    Given I am on the projects page
    When I follow "Add Project"
    And I fill in the following:
      | Project Name      | Test Project        |
    And I press "Create Project"
    Then I should see "Test Project"
    And I should see "The project Test Project was successfully created."
  
  Scenario: I should be able to edit my project
    Given I have a project "test project"
    And I am on the projects page
    When I follow "Edit"
    And I fill in the following:
      | Project Name      | Updated Project     |
    And I press "Update"
    Then I should see "Updated Project"
    And I should see "The project was successfully updated."

  Scenario: I should be able to delete my project
    Given I have a project "test project"
    And I am on the projects page
    When I follow "Delete"
    Then I should not see "Updated Project"
    And I should see "The project was successfully removed."
