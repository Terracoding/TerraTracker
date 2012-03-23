Given /^I have a company user "([^"]*)"$/ do |arg1|
  steps %Q{
    Given I am on the company page
    When I follow "Add User"
    And I fill in the following:
      | First Name            | Jane                  |
      | Last Name             | Doe                   |
      | Email                 | jane@example.com      |
      | Password              | password              |
    And I press "Create Company User"
    Then I should see "You have successfully added Jane Doe to your company."
  }
end