class UsersController < ApplicationController
   before_action :require_login, except: [:new, :create]
   before_action :require_correct_user, only: [:show, :edit, :update, :destroy]
   def new
      render :new
   end

   def edit
      @user = User.find(params[:id])
      render :edit
   end

   def create
      @user = User.new(user_params)
      if @user.save
         session[:user_id] = @user.id
         redirect_to ("/users/#{@user.id}")
      else
         flash[:errors] = @user.errors.full_messages
         redirect_to ("/users/new")
      end
   end

   def show
      @user = User.find(params[:id])
      @events = Event.all
      @user_state = @user.state
      @my_state = Event.where(state: @user_state)
      @not_my_state = Event.where.not(state: @user_state)
   end

   def update
      @user = User.find(params[:id])
      if @user.update_attributes(user_params)
         flash[:success] = "User Information Was Successfully Updated"
      redirect_to ("/users/#{@user.id}")
     else
      flash[:errors] = @user.errors.full_messages
      redirect_to "/users/#{@user.id}/edit"
     end
   end

   def destroy
      @user = User.destroy(params[:id])
      session[:user_id] = nil
      redirect_to :root
   end

   private
     def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :city, :state, :password, :password_confirmation)
     end
end
