Given /^I have a company user "([^"]*)"$/ do |firstname|
  steps %Q{
    Given I am on the company page
    When I follow "Add User"
    And I fill in the following:
      | First Name            | #{firstname}                  |
      | Last Name             | Doe                           |
      | Email                 | #{firstname.downcase}doe@example.com   |
      | Password              | password                      |
    And I press "Create Company User"
    Then I should see "You have successfully added #{firstname} Doe to your company."
  }
end