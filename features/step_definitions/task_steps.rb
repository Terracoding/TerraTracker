Given /^I have the task "([^"]*)"$/ do |arg1|
  steps %Q{
    Given I am on the tasks page
    When I follow "Add Task"
    And I select "Test Project" from "Project"
    And I fill in the following:
      | Task Name         | Test Task            |
    And I press "Create Task"
    Then I should see "Test Task"
    And I should see "The task Test Task was successfully created."
  }
end