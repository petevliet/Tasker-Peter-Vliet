class SessionsController < ApplicationController

  def signin
    @user = User.find_by(email:params[:email])
  end

  def create
    @user = User.find_by(email:params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/', notice: 'Welcome!'
    else
      flash[:alert] = 'Username / password combination is invalid. <br>'.html_safe
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/', notice: 'Fare thee well.'
  end

end
