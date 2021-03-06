class RegistrationsController < ApplicationController
# Registration is created upon valid entries in 'Sign Up' option, additional users may also be created by current users in users path.
  def new
    @user = User.new
  end

  def create
    @user = User.new(registration_params)
    if @user.save
      session[:user_id] = @user.id
      redirect_to new_project_path, notice: 'New account!'
    else
      render :new
    end
  end

  private
  def registration_params
    params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
  end
end
