class CalendarsController < ApplicationController
  before_action :authenticate_user!

  def index
    query = EventScheduleQuery.new(Event.all)
    calendar_for(query)
  end

  def user_calendar
    query = EventScheduleQuery.new(current_user.events)
    calendar_for(query)
  end

  private

  def calendar_for(query)
    respond_to do |format|
      format.html
      format.json { render json: query.build(params[:start], params[:end]) }
    end
  end
end