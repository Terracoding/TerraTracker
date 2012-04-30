Given /^I am not logged in$/ do
  page.should_not have_content("Logout")
end
Given /^I am a user with the email "([^"]*)"$/ do |email|
  User.create!(:email => email, :password => "password", password_confirmation: "password", :firstname => "John", :lastname => "Doe", :owns_company => true)
end
Given /^I am signed in as user "([^"]*)"$/ do |email|
  steps %Q{
    Given I am on the login page
    And I am a user with the email "#{email}"
    When I fill in "Email" with "#{email}"
    And I fill in "Password" with "password"
    And I press "Login"
    Then I should see "Signed in successfully."
  }
end