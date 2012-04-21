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

Given /^"([^"]*)" has created an overdue bill with comment "([^"]*)" and reference "([^"]*)"$/ do |user,comment,reference|
  user = User.find_by_email("#{user.parameterize}@example.com")
  Bill.create!(user_id: user.id, company_id: user.company.id, reference_id: reference, value: 20.00, comment: comment, due_date: 3.days.ago, bill_date: 1.day.ago)
end

Given /^"([^"]*)" has created a bill due in the future with comment "([^"]*)" and reference "([^"]*)"$/ do |user,comment,reference|
  user = User.find_by_email("#{user.parameterize}@example.com")
  Bill.create!(user_id: user.id, company_id: user.company.id, reference_id: reference, value: 20.00, comment: comment, due_date: 3.days.from_now, bill_date: 1.day.ago)
end