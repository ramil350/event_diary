class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:edit, :update, :destroy]

  def new
    @event = Event.new(user: current_user)
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to user_calendar_path(current_user), notice: 'Event created successfully.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to user_calendar_path(current_user), notice: 'Event updated successfully.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to user_calendar_path(current_user), notice: 'Event deleted successfully.'
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