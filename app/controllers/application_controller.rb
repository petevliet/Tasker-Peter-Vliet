class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  class AccessDenied < StandardError
  end
  rescue_from AccessDenied, with: :record_not_found
  protect_from_forgery with: :exception

  before_action :set_memberships

  def set_memberships
    if current_user && current_user.admin
      @projects = Project.all
    elsif current_user
      @projects = current_user.projects
    end
  end

  def current_user
    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

  end

  def store_location
    session[:return_to] = request.url
  end

  def authenticate
    unless current_user
      session[:return_to] = request.fullpath
      redirect_to signin_path
      flash[:alert]= 'You must be logged in to view this page'
    end
  end

  def member_of?
    @project = Project.find(params[:id])
    unless @project.users.include?(current_user) || current_user.admin
      redirect_to projects_path
      flash[:alert]= 'You do not have access to that project'
    end
  end

  def task_member_of?
    @project = Project.find(params[:project_id])
    unless @project.users.include?(current_user) || current_user.admin?
      redirect_to projects_path
      flash[:alert]= 'You do not have access to that project'
    end
  end

  def owner_of?
    @project = Project.find(params[:id])
    user_role = @project.memberships.where(user_id: current_user.id)
    unless user_role[0].role == "owner" || current_user.admin
      redirect_to project_path(@project)
      flash[:alert]= 'You do not have access'
    end
  end

  private
  def record_not_found
    render '../../public/404', layout: false
  end


  helper_method :current_user
end
