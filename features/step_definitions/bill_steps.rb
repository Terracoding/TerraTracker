Given /^I have a bill with comment "([^"]*)" and reference "([^"]*)"$/ do |comment,reference|
  steps %Q{
    Given I am on the bills page
    When I follow "Add Bill"
    And I fill in the following:
      | Reference         | #{reference}        |
      | Value             | 20.00               |
      | Comments          | #{comment}        |
    And I press "Create Bill"
    Then I should see "The bill was successfully created."
    And I should see "#{comment}"
  }
end