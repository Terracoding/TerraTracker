Given /^I have the project user "([^"]*)"$/ do |firstname|
  steps %Q{
    Given I am on the projects page
    When I follow "Show"
    And I follow "Add Project User"
    And I select "#{firstname} Doe" from "User"
    And I press "Add User"
    Then I should see "#{firstname} was successfully added to the project."
  }
end