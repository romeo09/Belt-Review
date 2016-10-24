class JoinsController < ApplicationController
   def create
      event = Event.find(params[:event_id])
      attendees = Join.create(user: current_user, event: event )
      redirect_to :back
   end
  def destroy
     join = Join.where(event_id: params[:id], user_id: session[:user_id]).first.destroy
     redirect_to :back
  end
end
