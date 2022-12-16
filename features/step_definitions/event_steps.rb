
Given /the following events exist/ do |events_table|
    events_table.hashes.each do |event|
      # event['user_id'] = User.find_by_email(event['user_id']).id
      Event.create event
    end
  end
  
  Then /I should see "(.*)" before "(.*)"/ do |e1, e2|
    #  ensure that that e1 occurs before e2.
    #  page.body is the entire content of the page as a string.
    expect(page.body.index(e1) < page.body.index(e2))
  end
  
  When /I (un)?check the following tags: (.*)/ do |uncheck, tag_list|
    tag_list.split(', ').each do |tag|
      step %{I #{uncheck.nil? ? '' : 'un'}check "tags_#{tag}"}
    end
  end
  
  Then /I should see all the events/ do
    # Make sure that all the movies in the app are visible in the table
    Event.all.each do |event|
      step %{I should see "#{event.event_name}"}
    end
  end

  Then /I should see all the valid events/ do
    # Make sure that all the movies in the app are visible in the table
    Event.where("end_time > ?", Time.now).each do |event|
      step %{I should see "#{event.event_name}"}
    end
  end

  When /^(?:|I )select the time "([^"]*)-([^"]*)-([^"]*) ([^"]*):([^"]*)" from "([^"]*)"$/ do |year, month, day, hour, minute, item|
    label = page.find('label', text: item)
    field = label['for']
    select(year,   :from => "#{field}_1i")
    select(month,  :from => "#{field}_2i")
    select(day,    :from => "#{field}_3i")
    select(hour,   :from => "#{field}_4i")
    select(minute, :from => "#{field}_5i")
  end

  # When /^(?:|I )select the time "([^ ]*) ([^ ]*) ([^ ]*) - ([^:]*):([^"]*)" as the "([^"]*)"$/ do |year, month, day, hour, minute, field|
  #   select(year,   :from => "#{field}_1i")
  #   select(month,  :from => "#{field}_2i")
  #   select(day,    :from => "#{field}_3i")
  #   select(hour,   :from => "#{field}_4i")
  #   select(minute, :from => "#{field}_5i")
  # end