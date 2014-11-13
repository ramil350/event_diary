class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:edit, :update]

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

  def edit
  end

  def update
    if @event.update_attributes(event_params)
      flash[:notice] = 'Event updated successfully.'
      redirect_to user_calendar_path(current_user)
    else
      render 'edit'
    end
  end

  def index
    render json: Event.for_user(current_user).over_period(params[:start], params[:end])
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def event_params
    params.require(:event).permit(:title, :starts_on, :recurring, :repeats)
  end
end