class SessionsController < ApplicationController

  def new
    @user = User.new
    @identity = env['omniauth.identity']
  end

  def create
    user = User.from_omniauth(env["omniauth.auth"])
    puts "************************88"
    puts user.inspect
	#if user.confirmed == "true"
		session[:user_id] = user.id
		flash[:notice] = "Successfully logged in from " + env["omniauth.auth"][:provider].capitalize
		redirect_to welcome_index_path
#	else
#		UserMailer.registration_confirmation(user).deliver
#		redirect_to petitions_path, notice: "A confirmation e-mail has been send to your inbox."
#	end
  end

  def destroy
    session[:user_id] = nil
    cookies.delete(:remember_token)
    current_user = nil
    redirect_to root_path, notice: "Signed out!"
  end

  def failure
    redirect_to root_path, alert: "Authentication failed, please try again."
  end

end