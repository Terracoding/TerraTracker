Given /^I own the company "([^"]*)"$/ do |company|
  steps %Q{
    Given I am on the dashboard page
    When I follow "Company"
    And I fill in the following:
      | Company Name            | #{company}          |
      | Registration Number     | 1001                |
    And I press "Create Company"
    Then I should see "Company Overview"
    And I should see "The company #{company} was successfully created."
  }
end