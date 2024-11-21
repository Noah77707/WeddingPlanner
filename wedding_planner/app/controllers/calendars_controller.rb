class CalendarsController < ApplicationController
  before_action :set_user, only: [:calendars, :events, :new_event]

  # Redirect to Google OAuth authorization page
  def redirect
    redirect_to user_google_oauth2_omniauth_authorize_path
  end

  # Callback action after Google OAuth authorization
  def callback
    # This action is handled automatically by OmniAuth, so you may not need to do much here
    if current_user
      # Handle the OAuth response for the current user
      response = request.env["omniauth.auth"]

      # Update user's Google tokens
      current_user.update!(
        google_access_token: response['credentials']['token'],
        google_refresh_token: response['credentials']['refresh_token'],
        google_token_expires_at: Time.at(response['credentials']['expires_at'])
      )

      redirect_to calendars_url
    else
      redirect_to root_path, alert: 'You need to sign in first.'
    end
  end
  # Fetch the user's calendars
  def calendars
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_user.google_access_token

    @calendar_list = service.list_calendar.list
  end

  # Fetch events for a specific calendar
  def events
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_user.google_access_token


    @event_list = service.list_events(params[:calendar_id])
  end

  # Create a new event for the user's calendar
  def new_event
    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = current_user.google_access_token

    today = Date.today
    event = Google::Apis::CalendarV3::Event.new({
                                                  start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
                                                  end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
                                                  summary: 'New event!'
                                                })

    service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
  end

  private

  # Set the user based on the logged-in user (ensure user is authenticated)
  def set_user
    @user = current_user
    redirect_to root_path, alert: 'Please sign in to access your calendar.' unless @user
  end

  def client_options
    {
      client_id: Rails.application.credentials.google(:google_client_id),
      client_secret: Rails.application.credentials.google(:google_client_secret),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,
      redirect_uri: callback_url
    }
    end
end