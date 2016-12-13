class SessionsController < ApplicationController
  def create
    user = User.find_by(email: params[:email])

    if user && user.try(:authenticate, params[:password])
      session[:user_id] = user.id
      redirect_to events_path
    else

      flash[:login_error] = "login"
      flash[:errors] = []

      flash[:login_email] = params[:email]

      if user
        flash[:errors].insert(-1, "Invalid Password")
      else
        flash[:errors].insert(-1, "User not found")
      end

      redirect_to new_session_path
    end
  end

  def new
    if (flash[:first_name] == nil &&
      flash[:login_email] == nil &&
      flash[:last_name] == nil &&
      flash[:email] == nil &&
      flash[:location] == nil &&
      flash[:state] == nil)

      flash[:login_email] = ""
      flash[:first_name] = ""
      flash[:last_name] = ""
      flash[:email] = ""
      flash[:location] = ""
      flash[:state] = "TX"
    end

  end

  def destroy
    session[params[:id]] = nil
    redirect_to new_session_path
  end
end
