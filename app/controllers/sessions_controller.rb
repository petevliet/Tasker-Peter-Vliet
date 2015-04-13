class SessionsController < ApplicationController

  def signin
    @user = User.find_by(email:params[:email])
  end

  def create
    @user = User.find_by(email:params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      if session[:return_to].nil?
        redirect_to '/projects', notice: 'Welcome!'
      else
        redirect_to session[:return_to], notice: 'Welcome!'
        session[:return_to] = nil
      end
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
