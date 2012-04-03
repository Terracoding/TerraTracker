Feature: Dashboard
  So that: I am able to view my account overview
  As a: User
  I can: View my account highlights

  Background:
    Given I am signed in as user "john@example.com"
    And I own the company "TestCompany"

  Scenario: I should see my projects on the dashboard
    Given I have a project "test project"
    When I am on the dashboard page
    Then I should see "Projects"
    And I should see "test project"

  Scenario: I should see my account usage for one user
    Given I have a project "Test Project"
    When I am on the dashboard page
    Then I should see "Projects: 1"
    And I should see "Users: 1"
    And I should see "Plan: Basic"
