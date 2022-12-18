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

When /^I search event name "([^"]*)"$/ do |e|
    fill_in("search_by_name", :with => e)
    click_button("Search Name")
end

When /^I search event date "([^"]*)"$/ do |d|
    fill_in("search_by_time", :with => d)
    click_button("Search Day")
end

When /^I should see a pin on the map$/ do
    expect(page).to have_selector('#markers img', count: 1)
end

And(/^(?:I expect a Google map to load|the map has been loaded)$/) do
    # sleep(0.1) until page.evaluate_script('$.active') == 0
    expect(page).to have_css '#map .gm-style'
end