Given /^I have a project "([^"]*)"$/ do |project|
  steps %Q{
    Given I am on the projects page
    When I follow "Add Project"
    And I fill in the following:
      | Project Name      | #{project}        |
    And I select "Active" from "Status"
    And I press "Create Project"
    Then I should see "#{project}"
    And I should see "The project #{project} was successfully created."
  }
end