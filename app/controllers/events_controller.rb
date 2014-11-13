class EventsController < ApplicationController
  def new
    @event = Event.new(user: current_user)
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      flash[:notice] = 'Event created successfully.'
      redirect_to user_calendar_path(current_user)
    else
      render 'new'
    end
  end

  private

  def event_params
    params.require(:event).permit(:title, :starts_on, :recurring, :repeats)
  end
end