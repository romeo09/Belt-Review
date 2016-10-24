class EventsController < ApplicationController
   before_action :require_login, only: [:index, :create, :edit, :update, :destroy]
  def index
     @user = User.where(id: session[:user_id]).first
     @events = Event.all
  end
  def new
     render :new
  end 
  def show
     @user = User.find(session[:user_id])
     @event = Event.where(id: params[:id]).first
     @attendees = Event.first.guests
     @comment = Comment.where(event_id: params[:id])
  end

  def create
     @user = current_user
     event = Event.new(name: event_params[:name], date: event_params[:date], city: event_params[:city], state: event_params[:state], user_id: session[:user_id] )
       flash["success"] = "Your Event Has Been Added!"
       if event.save
          redirect_to :back
       else
          flash[:errors] = event.errors.full_messages
          redirect_to :back
       end
  end

  def edit
     @user = User.find(session[:user_id])
     @events = Event.find(params[:id])
     render :edit
  end

  def update
     @user = User.find(session[:user_id])
     @events = Event.find(params[:id])
     if @events.update_attributes(event_params)
       flash[:success] = "Event Details Have Been Successfully Updated"
     redirect_to ("/users/#{@user.id}")
   else
     flash[:errors] = @user.errors.full_messages
     redirect_to :back
   end
  end

  def destroy
     event = Event.destroy(params[:id])
     event.destroy if event.user == current_user
     redirect_to ("/users/#{current_user.id}")
  end

  def event_comments
     @user = current_user
     @comment = Comment.new(content: comment_params[:content], event_id: params[:event_id], user_id: current_user.id)
       if @comment.save
          redirect_to :back
       else
          flash[:errors] = @comment.errors.full_messages
          redirect_to :back
       end
  end

  private
    def event_params
      params.require(:event).permit(:name, :date, :city, :state)
    end
    def comment_params
      params.require(:comment).permit(:content)
    end
end
