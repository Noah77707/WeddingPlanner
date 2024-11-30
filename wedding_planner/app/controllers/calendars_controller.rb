class CalendarsController < ApplicationController
  before_action :set_user, only: [:calendars, :events, :new_event]

  # Redirect to Google OAuth authorization page
  def redirect

    client = Signet::OAuth2::Client.new(client_options)

    redirect_to client.authorization_uri.to_s, allow_other_host: true
  end


  # Callback action after Google OAuth authorization
  def callback
    def callback
      client = Signet::OAuth2::Client.new(client_options)
      client.code = params[:code]

      response = client.fetch_access_token!

      session[:authorization] = response

      redirect_to calendars_url
    end
  end

  # Fetch the user's calendars
  def calendars
    client = Signet::OAuth2::Client.new(client_options)

    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @calendar_list = service.list_calendar_lists
  end



  # Fetch events for a specific calendar
  def events
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    @event_list = service.list_events(params[:calendar_id])
  end

  # Create a new event for the user's calendar
  def new_event
    client = Signet::OAuth2::Client.new(client_options)
    client.update!(session[:authorization])

    service = Google::Apis::CalendarV3::CalendarService.new
    service.authorization = client

    today = Date.today

    event = Google::Apis::CalendarV3::Event.new(
                                                  start: Google::Apis::CalendarV3::EventDateTime.new(date: today),
                                                  end: Google::Apis::CalendarV3::EventDateTime.new(date: today + 1),
                                                  summary: 'New event!'
                                                )

    service.insert_event(params[:calendar_id], event)

    redirect_to events_url(calendar_id: params[:calendar_id])
  end


  # Refresh the user's Google token if expired
  def refresh_google_token
    service = Google::Apis::CalendarV3::CalendarService.new

    # Initialize credentials
    credentials = Google::Auth::UserRefreshCredentials.new(
      client_id: Rails.application.credentials.google(:google_client_id),
      client_secret: Rails.application.credentials.google(:google_client_secret),
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,  # Ensure this scope is correct
      access_token: current_user.google_access_token,
      refresh_token: current_user.google_refresh_token,
      expiration_time: current_user.google_token_expires_at
    )

    # If the access token is expired, refresh it using the refresh token
    if credentials.expired?
      begin
        credentials.fetch_access_token!
        # Update the user's access token and expiration time
        current_user.update!(
          google_access_token: credentials.access_token,
          google_token_expires_at: credentials.expires_at
        )
      rescue Google::Auth::RefreshError => e
        Rails.logger.error("Failed to refresh token: #{e.message}")
        redirect_to root_path, alert: 'Failed to refresh Google OAuth token. Please reauthenticate.'
        return
      end
    end

    # Assign the refreshed credentials to the service
    service.authorization = credentials

    service
  end

  private

  # Set the user based on the logged-in user (ensure user is authenticated)
  def set_user
    @user = current_user
    redirect_to root_path, alert: 'Please sign in to access your calendar.' unless @user
  end

  def client_options
    {
      client_id: Rails.application.credentials.dig(:google, :google_client_id),
      client_secret: Rails.application.credentials.dig(:google, :google_client_secret),
      authorization_uri: 'https://accounts.google.com/o/oauth2/auth',
      token_credential_uri: 'https://accounts.google.com/o/oauth2/token',
      scope: Google::Apis::CalendarV3::AUTH_CALENDAR,  # Ensure this scope is correct
      redirect_uri: callback_url
    }
  end
end
