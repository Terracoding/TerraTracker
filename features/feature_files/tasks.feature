Feature: Tasks
  So that: I am able to assign tasks
  As a: User
  I can: Create and manage tasks

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
  
  Scenario: I should be redirect to create a project if I visit the tasks page
    Given I am on the tasks page
    Then I should see "Create Project"
    And I should see "You need to set up a project before you can create a task."

  Scenario: I should be able to create a task
    Given I have a project "Test Project"
    And I am on the tasks page
    When I follow "Add Task"
    And I select "Test Project" from "Project"
    And I fill in the following:
      | Task Name         | Test Task           |
      | Rate              | 20.00               |
    And I check "Billable"
    And I press "Create Task"
    Then I should see "Test Task"
    And I should see "The task Test Task was successfully created."

  Scenario: I should be able to edit a task
    Given I have a project "Test Project"
    And I have the task "Test Task"
    And I am on the tasks page
    When I follow "Edit"
    And I fill in the following:
      | Task Name       | New Task Name       |
    And I press "Update"
    Then I should see "New Task Name"
    And I should see "The task was successfully updated."

  Scenario: I should be able to change a tasks project
    Given I have a project "Test Project"
    And I have a project "Foo Project"
    And I have the task "Test Task"
    And I am on the tasks page
    When I follow "Edit"
    And I select "Foo Project" from "Project"
    And I press "Update"
    Then I should see "Test Task"
    And I should see "The task was successfully updated."
    And I should see "Foo Project"
    
  Scenario: I should be able to delete a task
    Given I have a project "Test Project"
    And I have the task "Test Task"
    And I am on the tasks page
    When I follow "Delete"
    Then I should not see "Test Task"
    And I should see "The task was successfully removed."
