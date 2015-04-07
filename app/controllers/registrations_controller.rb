class RegistrationsController < ApplicationController

  def new
    @user = Registration.new
  end

  def create
    @user = Registration.new(registration_params)

    if @user.save
      session[:registration_id] = @user.id
      redirect_to new_project_path, notice: 'New account!'
    else
      render :new
    end
  end

  private
  def registration_params
    params.require(:registration).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
