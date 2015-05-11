class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email])

  	if user && user.authenticate(params[:password])
	  	session[:user_id] = user.id
	  	flash[:success] = "You've been logged in!"
	  	redirect_to contacts_path
	  else	  	
	  	flash[:error] = "There was a problem logging in. Please check your email and/or password."
	  	render action: 'new'
	  end
  end

  def destroy
  	session[:user_id] = nil
  	reset_session
  	redirect_to root_path, notice: "You have been logged out."
  end

  
end
