class UserSessionsController < ApplicationController
  def new
  end

  def create
  	user = User.find_by(email: params[:email].downcase)

  	if user && user.authenticate(params[:password])
      if params[:remember_me]
        signed_token = Rails.application.message_verifier(:remember_me).generate(user.id)
        cookies.permanent.signed[:remember_me_token] = signed_token
      end
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
    cookies.delete(:remember_me_token)
  	reset_session
  	redirect_to "/login", notice: "You have been logged out."
  end

  
end
