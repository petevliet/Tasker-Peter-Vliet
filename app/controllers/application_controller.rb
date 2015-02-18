class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def current_user

    User.find_by_id(session[:user_id])

    if session[:user_id]
      @current_user ||= User.find(session[:user_id])
    end

  end

  def authenticate
    unless current_user flash[:alert]= 'not signed in'
      redirect_to signin_path
    end
  end

  helper_method :current_user
end
