class SessionsController < ApplicationController
  def index
     reset_session
  end
  def create
     user = User.find_by_email(params[:email])

     if user && user.authenticate(params[:password])
        session[:user_id] = user.id
        redirect_to ("/users/#{user.id}")
     else
        flash[:errors] = user.errors.full_messages
        redirect_to :root
     end
  end

  def destroy
     session[:user_id] = nil
     redirect_to :root
  end
end
