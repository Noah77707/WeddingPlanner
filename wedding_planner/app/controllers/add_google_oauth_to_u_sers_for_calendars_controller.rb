class AddGoogleOauthToUSersForCalendarsController < ApplicationController
  before_action :set_add_google_oauth_to_u_sers_for_calendar, only: %i[ show edit update destroy ]

  # GET /add_google_oauth_to_u_sers_for_calendars or /add_google_oauth_to_u_sers_for_calendars.json
  def index
    @add_google_oauth_to_u_sers_for_calendars = AddGoogleOauthToUSersForCalendar.all
  end

  # GET /add_google_oauth_to_u_sers_for_calendars/1 or /add_google_oauth_to_u_sers_for_calendars/1.json
  def show
  end

  # GET /add_google_oauth_to_u_sers_for_calendars/new
  def new
    @add_google_oauth_to_u_sers_for_calendar = AddGoogleOauthToUSersForCalendar.new
  end

  # GET /add_google_oauth_to_u_sers_for_calendars/1/edit
  def edit
  end

  # POST /add_google_oauth_to_u_sers_for_calendars or /add_google_oauth_to_u_sers_for_calendars.json
  def create
    @add_google_oauth_to_u_sers_for_calendar = AddGoogleOauthToUSersForCalendar.new(add_google_oauth_to_u_sers_for_calendar_params)

    respond_to do |format|
      if @add_google_oauth_to_u_sers_for_calendar.save
        format.html { redirect_to @add_google_oauth_to_u_sers_for_calendar, notice: "Add google oauth to u sers for calendar was successfully created." }
        format.json { render :show, status: :created, location: @add_google_oauth_to_u_sers_for_calendar }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @add_google_oauth_to_u_sers_for_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /add_google_oauth_to_u_sers_for_calendars/1 or /add_google_oauth_to_u_sers_for_calendars/1.json
  def update
    respond_to do |format|
      if @add_google_oauth_to_u_sers_for_calendar.update(add_google_oauth_to_u_sers_for_calendar_params)
        format.html { redirect_to @add_google_oauth_to_u_sers_for_calendar, notice: "Add google oauth to u sers for calendar was successfully updated." }
        format.json { render :show, status: :ok, location: @add_google_oauth_to_u_sers_for_calendar }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @add_google_oauth_to_u_sers_for_calendar.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /add_google_oauth_to_u_sers_for_calendars/1 or /add_google_oauth_to_u_sers_for_calendars/1.json
  def destroy
    @add_google_oauth_to_u_sers_for_calendar.destroy!

    respond_to do |format|
      format.html { redirect_to add_google_oauth_to_u_sers_for_calendars_path, status: :see_other, notice: "Add google oauth to u sers for calendar was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_add_google_oauth_to_u_sers_for_calendar
      @add_google_oauth_to_u_sers_for_calendar = AddGoogleOauthToUSersForCalendar.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def add_google_oauth_to_u_sers_for_calendar_params
      params.fetch(:add_google_oauth_to_u_sers_for_calendar, {})
    end
end
