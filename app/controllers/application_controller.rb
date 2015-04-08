class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user

    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

  end

  def authenticate
    unless current_user
      redirect_to signin_path
      flash[:alert]= 'You must be logged in to view this page'
    end
  end

  def member_of?
    @project = Project.find(params[:id])
    unless @project.memberships.where(user_id: current_user.id) != []
      redirect_to projects_path
      flash[:notice]= 'You do not have access to that project'
    end
  end

  helper_method :current_user
end
