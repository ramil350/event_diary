class UsersController < ApplicationController
  def show
    @user = User.find(params[:id])
  end

  def calendar
    @events = Event.where(user: current_user)
  end
end