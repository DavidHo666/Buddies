Given /the following users exist/ do |users_table|
    users_table.hashes.each do |user|
      User.create user
    end
  end

When /^I signup with email "([^"]*)" and password "([^"]*)"$/ do |e, p|
    fill_in("Email", :with => e)
    fill_in("Password", :with => p)
    fill_in("Password confirmation", :with => p)
    click_button("Sign up")
end

When /^I signin with email "([^"]*)" and password "([^"]*)"$/ do |e, p|
    fill_in("Email", :with => e)
    fill_in("Password", :with => p)
    click_button("Log in")
end

When /^I join event "([^"]*)"$/ do |e|
    click_link("More about #{e}")
    click_button("Participate")
end

When /^I leave event "([^"]*)"$/ do |e|
    click_link("More about #{e}")
    click_button("Leave")
end
