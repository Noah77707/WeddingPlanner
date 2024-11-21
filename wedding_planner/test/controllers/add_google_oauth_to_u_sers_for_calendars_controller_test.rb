require "test_helper"

class AddGoogleOauthToUSersForCalendarsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @add_google_oauth_to_u_sers_for_calendar = add_google_oauth_to_u_sers_for_calendars(:one)
  end

  test "should get index" do
    get add_google_oauth_to_u_sers_for_calendars_url
    assert_response :success
  end

  test "should get new" do
    get new_add_google_oauth_to_u_sers_for_calendar_url
    assert_response :success
  end

  test "should create add_google_oauth_to_u_sers_for_calendar" do
    assert_difference("AddGoogleOauthToUSersForCalendar.count") do
      post add_google_oauth_to_u_sers_for_calendars_url, params: { add_google_oauth_to_u_sers_for_calendar: {  } }
    end

    assert_redirected_to add_google_oauth_to_u_sers_for_calendar_url(AddGoogleOauthToUSersForCalendar.last)
  end

  test "should show add_google_oauth_to_u_sers_for_calendar" do
    get add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
    assert_response :success
  end

  test "should get edit" do
    get edit_add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
    assert_response :success
  end

  test "should update add_google_oauth_to_u_sers_for_calendar" do
    patch add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar), params: { add_google_oauth_to_u_sers_for_calendar: {  } }
    assert_redirected_to add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
  end

  test "should destroy add_google_oauth_to_u_sers_for_calendar" do
    assert_difference("AddGoogleOauthToUSersForCalendar.count", -1) do
      delete add_google_oauth_to_u_sers_for_calendar_url(@add_google_oauth_to_u_sers_for_calendar)
    end

    assert_redirected_to add_google_oauth_to_u_sers_for_calendars_url
  end
end
