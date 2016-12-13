class UsersController < ApplicationController
  def index
  end

  def new
  end

  def create
    user  = User.new(user_params)

    if user.save()
      session[:user_id] = user.id
      redirect_to events_path
    else
      flash[:login_error] = "registration"
      flash[:errors] = user.errors.full_messages

      flash[:first_name] = user_params[:first_name]
      flash[:last_name] = user_params[:last_name]
      flash[:email] = user_params[:email]
      flash[:location] = user_params[:location]
      flash[:state] = user_params[:state]

      redirect_to new_session_path
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    user = User.find(params[:id])

    if user.update(user_update_params)
      redirect_to events_path
    else
      flash[:errors] = user.errors.full_messages
      redirect_to edit_user_path
    end
  end


  private
  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state,  :password, :password_confirmation)
  end

  def user_update_params
    params.require(:user).permit(:first_name, :last_name, :email, :location, :state)
  end


end
