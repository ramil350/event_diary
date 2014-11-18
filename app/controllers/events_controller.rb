class EventsController < ApplicationController
  before_action :authenticate_user!
  before_action :find_event, only: [:edit, :update, :destroy]
  before_action :authorize_user!, only: [:edit, :update, :delete]

  def new
    @event = Event.new(user: current_user)
  end

  def create
    @event = current_user.events.build(event_params)
    if @event.save
      redirect_to my_calendar_path, notice: 'Event created successfully.'
    else
      render 'new'
    end
  end

  def edit
  end

  def update
    respond_to do |format|
      if @event.update_attributes(event_params)
        format.html { redirect_to my_calendar_path, notice: 'Event updated successfully.' }
        format.json { head :no_content }
      else
        format.html { render 'edit' }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @event.destroy
    redirect_to my_calendar_path, notice: 'Event deleted successfully.'
  end

  private

  def find_event
    @event = Event.find(params[:id])
  end

  def authorize_user!
    unless @event.user == current_user
      flash[:alert] = 'Unauthorized access!'
      redirect_to my_calendar_path
    end
  end

  def event_params
    params.require(:event).permit(:title, :starts_on, :recurring, :repeats)
  end
end