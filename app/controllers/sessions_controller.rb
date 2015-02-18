class SessionsController < ApplicationController

  def create
    @user = User.find_by(email:params[:email])
    if @user && @user.authenticate(params[:password])
      session[:user_id] = @user.id
      redirect_to '/', notice: 'Welcome!'
    else
      flash[:alert] = 'something went wrong.'
      render :new
    end
  end

  def destroy
    session.clear
    redirect_to '/', notice: 'Fare thee well.'
  end

end
