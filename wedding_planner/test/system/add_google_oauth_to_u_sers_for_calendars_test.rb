require "application_system_test_case"

class AddGoogleOauthToUSersForCalendarsTest < ApplicationSystemTestCase
  setup do
    @add_google_oauth_to_u_sers_for_calendar = add_google_oauth_to_u_sers_for_calendars(:one)
  end

  test "visiting the index" do
    visit add_google_oauth_to_u_sers_for_calendars_url
    assert_selector "h1", text: "Add google oauth to u sers for calendars"
  end

  test "should create add google oauth to u sers for calendar" do
    visit add_google_oauth_to_u_sers_for_calendars_url
    click_on "New add google oauth to u sers for calendar"

    click_on "Create Add google oauth to u sers for calendar"

    assert_text "Add google oauth to u sers for calendar was successfully created"
    click_on "Back"
  end

  test "should update Add google oauth to u sers for calendar" do
    visit add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
    click_on "Edit this add google oauth to u sers for calendar", match: :first

    click_on "Update Add google oauth to u sers for calendar"

    assert_text "Add google oauth to u sers for calendar was successfully updated"
    click_on "Back"
  end

  test "should destroy Add google oauth to u sers for calendar" do
    visit add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
    click_on "Destroy this add google oauth to u sers for calendar", match: :first

    assert_text "Add google oauth to u sers for calendar was successfully destroyed"
  end
end
