class RegistrationsController < SessionsController
	def new
	  @user = User.new
	  @user.apply_omniauth(session[:omniauth])
	  @user.valid?
	end
end
