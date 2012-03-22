Given /^I am not logged in$/ do
  page.should_not have_content("Logout")
end