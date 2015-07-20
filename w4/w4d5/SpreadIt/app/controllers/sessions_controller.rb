class SessionsController < ApplicationController
  def new
    @user = User.new
    render :new
  end

  def create
    @user = User.find_by_credentials(user_params[:username], user_params[:password])
    if @user.nil?
      flash.now[:errors] = ["Log in information is incorrect."]
      @user = User.new(username: user_params[:username])
      render :new
    elsif
      flash[:notice] = "You have successfully logged in!"
      login_user!(@user)
      redirect_to root_url
    end
  end

  def destroy
    logout_user!(current_user)
    redirect_to new_session_url
  end
end
