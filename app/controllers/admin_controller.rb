class AdminController < ApplicationController
  def index
    
  end

  def users
      @users = User.all
  end

  def projects
      @project = Project.all
  end

  def updateUser
    @user = User.find(params[:id])
    @user.name = params[:name]
    @identity = Identity.where(:email => @user.email).first
    if(@user.email != params[:email])
      @user.email = params[:email]
      if !@identity.nil?
        @identity.email = params[:email]
        @identity.save
      end
    end
    @user.role = params[:role]
    @user.save
    render :text => "saved successfully"
  end

  def deleteUser
    @user = User.find(params[:id])
    @identity = Identity.where(:email => @user.email).first
    if !@identity.nil?
        @identity.email = params[:email]
        @identity.destroy
    end
    @user.destroy
  end
  
end
