class RegistrationsController < ApplicationController

  def new
    @user = Registration.new
  end

  def create
    @user = Registration.new(registration_params)
    session[:user_id] = @user.id

    if @user.save
      redirect_to '/', notice: 'New account!'
    else
      render :new
    end
  end

  private
  def registration_params
    params.require(:registration).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
