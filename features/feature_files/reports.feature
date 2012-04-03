Feature: Reports
  So that: I am able to output my timesheets
  As a: User
  I can: Create and edit reports

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"
    And I have a project "Test Project"
    And I have the task "Test Task"
    And I have a timeslip
    
  Scenario: I should be able to create a report for all projects and tasks
    Given I am on the reports page
    And I select "This Week" from "Timeframe"
    And I select "All Projects" from "Project"
    And I select "All Tasks" from "Task"
    And I select "John Doe" from "User"
    And I press "Generate Report"
    Then I should see "Timesheet for John Doe"
    And I should see "Test Task"
    And I should see "This is a test comment"
    And I should see "Total Hours: 1.0"

  Scenario: I should be able to create a report for a specific project and task
    Given I am on the reports page
    And I select "This Week" from "Timeframe"
    And I select "Test Project" from "Project"
    And I select "Test Task" from "Task"
    And I select "John Doe" from "User"
    And I press "Generate Report"
    Then I should see "Timesheet for John Doe"
    And I should see "Test Task"
    And I should see "This is a test comment"
    And I should see "Total Hours: 1.0"
