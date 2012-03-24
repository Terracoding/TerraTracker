Feature: Tasks
  So that: I am able to assign tasks
  As a: User
  I can: Create and manage tasks

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
    And I have a project "Test Project"

  Scenario: I should be able to create a task
    Given I am on the tasks page
    When I follow "Add Task"
    And I select "Test Project" from "Project"
    And I fill in the following:
      | Task Name         | Test Task            |
    And I press "Create Task"
    Then I should see "Test Task"
    And I should see "The task Test Task was successfully created."
    
  Scenario: I should be able to delete a task
    Given I have the task "Test Task"
    And I am on the tasks page
    When I follow "Delete"
    Then I should not see "Test Task"
    And I should see "The task was successfully removed."
