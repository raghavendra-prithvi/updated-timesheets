class ApplicationController < ActionController::Base
  protect_from_forgery
  include SessionsHelper
  def require_login
    puts params.inspect
    if !session[:user_id].nil?
      @current_user = User.find(session[:user_id])
    else
      redirect_to :root
    end
  end


end
