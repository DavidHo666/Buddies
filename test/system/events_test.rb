require "application_system_test_case"

class EventsTest < ApplicationSystemTestCase
  setup do
    @event = events(:one)
  end

  test "visiting the index" do
    visit events_url
    assert_selector "h1", text: "Events"
  end

  test "should create event" do
    visit events_url
    click_on "New event"

    fill_in "Address", with: @event.address
    fill_in "Applicants", with: @event.applicants_id
    fill_in "Available spots", with: @event.available_spots
    fill_in "Description", with: @event.description
    fill_in "End time", with: @event.end_time
    fill_in "Event name", with: @event.event_name
    fill_in "Occupied spots", with: @event.occupied_spots
    fill_in "Organizer", with: @event.organizer_id
    fill_in "Pictures", with: @event.pictures
    fill_in "Price", with: @event.price
    fill_in "Start time", with: @event.start_time
    fill_in "Tag", with: @event.tag
    click_on "Create Event"

    assert_text "Event was successfully created"
    click_on "Back"
  end

  test "should update Event" do
    visit event_url(@event)
    click_on "Edit this event", match: :first

    fill_in "Address", with: @event.address
    fill_in "Applicants", with: @event.applicants_id
    fill_in "Available spots", with: @event.available_spots
    fill_in "Description", with: @event.description
    fill_in "End time", with: @event.end_time
    fill_in "Event name", with: @event.event_name
    fill_in "Occupied spots", with: @event.occupied_spots
    fill_in "Organizer", with: @event.organizer_id
    fill_in "Pictures", with: @event.pictures
    fill_in "Price", with: @event.price
    fill_in "Start time", with: @event.start_time
    fill_in "Tag", with: @event.tag
    click_on "Update Event"

    assert_text "Event was successfully updated"
    click_on "Back"
  end

  test "should destroy Event" do
    visit event_url(@event)
    click_on "Destroy this event", match: :first

    assert_text "Event was successfully destroyed"
  end
end
