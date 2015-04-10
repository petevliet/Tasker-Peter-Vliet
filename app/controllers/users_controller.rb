class UsersController < ApplicationController
  layout 'current_user_layout'

  # before_action :admin_signup, only: :create

  def index
    @users = User.all
  end

  def show
    @user = User.find(params[:id])
    if @user != current_user
      @this_user = @user
    end
  end

  def edit
    @user = User.find(params[:id])
    if @user != current_user
      raise AccessDenied
    end
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new(user_params)
    if @user.save
      redirect_to users_path, notice: 'User was successfully created.'
    else
      render :new
    end
  end

  def update
    @user = User.find(params[:id])
      if @user.update(user_params)
        redirect_to users_path, notice: 'User was successfully updated.'
      else
        render :edit
      end
  end

  def destroy
    @user = User.find(params[:id])
    @comments = Comment.where(user_id: @user)
    if @user == current_user
      @user.destroy
      session.destroy
      redirect_to '/', notice: 'User successfully destroyed'
    else
      render :index, alert: 'You may only delete yourself'
    end
  end

  private
    def set_user
      @user = User.find(params[:id])
    end

    def user_params
      params.require(:user).permit(:first_name, :last_name, :email, :password, :admin)
    end

    def admin_signup
      @user = User.new(user_params)
      if @user.email == /^admin@example.com$/ && @user.password == /^password$/
        @user.admin = true
      end
    end

end
