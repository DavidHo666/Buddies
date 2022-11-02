# TL;DR: YOU SHOULD DELETE THIS FILE
#
# This file is used by web_steps.rb, which you should also delete
#
# You have been warned
module NavigationHelpers
  # Maps a name to a path. Used by the
  #
  #   When /^I go to (.+)$/ do |page_name|
  #
  # step definition in web_steps.rb
  #
  def path_to(page_name)
    case page_name

    when /^the (RottenPotatoes )?home\s?page$/ then "/events"

    when /^the create event page$/ then '/events/new'

    when /^the signin page$/ then '/users/sign_in'

    when /^the signup page$/ then '/users/sign_up'

    when /^the details page for user "([^"]*)"$/i
      user_path(User.find_by_email($1))

    when /^the edit page for user "([^"]*)"$/i
      edit_user_path(User.find_by_email($1))

    when /^the edit page for event "([^"]*)"$/i
      edit_event_path(Event.find_by_event_name($1))

    when /^the all users page$/ then '/users/'

    when /^the add new event page$/ then '/events/new'

    when /^the details page for event "([^"]*)"$/i
      event_path(Event.find_by_event_name($1))


      # Add more mappings here.
      # Here is an example that pulls values out of the Regexp:
      #
      #   when /^(.*)'s profile page$/i
      #     user_profile_path(User.find_by_login($1))

    else
      begin
        page_name =~ /^the (.*) page$/
        path_components = $1.split(/\s+/)
        self.send(path_components.push('path').join('_').to_sym)
      rescue NoMethodError, ArgumentError
        raise "Can't find mapping from \"#{page_name}\" to a path.\n" +
                "Now, go and add a mapping in #{__FILE__}"
      end
    end
  end
end

World(NavigationHelpers)