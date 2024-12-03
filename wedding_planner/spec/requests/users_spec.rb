require 'rails_helper'

RSpec.describe "Users", type: :request do
  describe "GET /users" do
    it "works! (now write some real specs)" do
      get users_path
      expect(response).to have_http_status(200)
    end
  end

  # I want it to test if the user is successfully created.
  describe "POST /users" do
    context "with valid parameters" do
      #  Test 1: create a new user and make sure it redirects
      it "creates a new user" do
        expect {
          post users_path, params: { user: { name: "Gordon", last_name: "Bill", partner: "fiancee", email: "GordanBill@gmail.com"}}
        }.to change(User, :count).by(1)

        expect(response).to have_http_status(:found)  # Expect redirect after creation
        follow_redirect!
        expect(response.body).to include("Aaron", "Gordon")  # Student's details in the response

      end
    end
  end
end

# frozen_string_literal: true
RSpec.describe CalendarsController, type: :routing do
  describe "routing" do
    it "routes to #caldenars" do
      expect(get: "/calendars").to route_to("calendars#calendars")
    end

    it "routes to #events" do
      expect(post: "/events/calendar_id").to route_to("calendars#events")
    end
  end
end