require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "POST /users" do
    context "with valid parameters" do
      it "creates a new user and redirects" do
        expect {
          post users_path, params: { user: { name: "Gordon", last_name: "Bill", partner: "fiancee", email: "gordon@fiancee.com", password: "password", password_confirmation: "password" } }
        }.to change(User, :count).by(1)

        # Expect a redirect response after user creation
        expect(response).to redirect_to(user_path(User.last)) # Expect a redirect to the newly created user's page

        # Follow the redirect
        follow_redirect!

        # Check that the user's details appear in the response body
        expect(response.body).to include("Gordon")
      end
    end
  end

  describe "POST /users" do
    context "with invalid parameters" do
      it "does not create a new user and renders the new template" do
        expect {
          post users_path, params: { user: { name: "Gordon", last_name: "Bill", partner: "fiancee" } }
        }.not_to change(User, :count)

        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.body).to include("2 errors prohibited this user from being saved")
      end
    end
  end

  describe "GET /users/:id" do
    let(:user) { create(:user) }

    it "returns the user's show page" do
      get user_path(user)

      expect(response).to have_http_status(:ok)
      expect(response.body).to include(user.name)
      expect(response.body).to include(user.email)
    end
  end

  describe "POST /users/sign_up" do
    it "signs up a user successfully" do
      post user_registration_path, params: { user: { email: "newuser@example.com", password: "password123", password_confirmation: "password123" } }

      expect(response).to have_http_status(:see_other)
      follow_redirect!
      expect(response.body).to include("Welcome! You have signed up successfully.")
    end
  end

  describe "GET /users/auth/google_oauth2/callback" do
    it "authenticates a user via Google" do
      OmniAuth.config.test_mode = true
      OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new(
        provider: 'google_oauth2',
        uid: '1234567890',
        info: { email: 'googleuser@example.com', name: 'Google User' },
        credentials: { token: 'mock_token', expires_at: 1.hour.from_now.to_i }
      )

      get '/users/auth/google_oauth2/callback'

      expect(response).to have_http_status(:found)
      follow_redirect!
      expect(response.body).to include('googleuser@example.com')
    end
  end

  describe "GET /users/:id" do
    it "redirects to login page if not logged in" do
      # Trying to access a user page without being logged in should redirect
      get user_path(1)

      expect(response).to redirect_to(new_user_session_path)
    end
  end
end


RSpec.describe CalendarsController, type: :routing do
  describe "routing" do
    it "routes to #calendars" do
      expect(get: "/calendars").to route_to("calendars#calendars")
    end

    it "routes to #events" do
      expect(post: "http://localhost:3000/events/a0904c1542f33eb19abdef8f65e7456139b5d4788d3f4648821f1093d06266ae@group.calendar.google.com").to route_to("calendars#new_event", calendar_id: "a0904c1542f33eb19abdef8f65e7456139b5d4788d3f4648821f1093d06266ae@group.calendar.google.com")
    end
  end
end