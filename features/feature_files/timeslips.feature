Feature: Timeslips
  So that: I am able to track my time
  As a: User
  I can: Create and edit timeslips

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
    And I have a project "Test Project"
    And I have the task "Test Task"
    
  Scenario: I should be able to create a timeslip
    Given I am on the timeslips page
    When I follow "Add Timeslip"
    And I select "Test Project" from "Project"
    And I select "Test Task" from "Task"
    And I select "John Doe" from "User"
    And I fill in "Date" with todays date
    And I fill in the following:
      | Comment         | This is a test comment                |
      | Hours           | 1.1                                   |
    And I press "Create Timeslip"
    Then I should see "The timeslip was successfully created."
    And I should see "This is a test comment"
    And I should see "1.1"

  Scenario: I should be able to create a timeslip with a different time format (1:30)
    Given I am on the timeslips page
    When I follow "Add Timeslip"
    And I select "Test Project" from "Project"
    And I select "Test Task" from "Task"
    And I select "John Doe" from "User"
    And I fill in "Date" with todays date
    And I fill in the following:
      | Comment         | This is a test comment                |
      | Hours           | 1:30                                  |
    And I press "Create Timeslip"
    Then I should see "The timeslip was successfully created."
    And I should see "This is a test comment"
    And I should see "1.5"

  Scenario: I should be able to edit a timeslip
    Given I have a timeslip
    And I am on the timeslips page
    When I follow "Edit"
    And I select "Test Project" from "Project"
    And I select "Test Task" from "Task"
    And I select "John Doe" from "User"
    And I fill in the following:
      | Comment         | This is a second test comment   |
      | Hours           | 2.1                             |
    And I press "Update"
    Then I should see "The timeslip was successfully updated."
    And I should see "This is a second test comment"
    And I should see "2.1"
  
  Scenario: I should be able to delete a timeslip
    Given I have a timeslip
    And I am on the timeslips page
    When I follow "Delete"
    Then I should see "The timeslip was successfully removed."
    And I should not see "This is a test comment"