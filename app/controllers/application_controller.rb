class ApplicationController < ActionController::Base
  protect_from_forgery
  
  helper_method :current_user_session, :current_user, :logged_in?
  
  protected 
  
  def current_user_session
    @current_user_session ||= UserSession.find
  end
  
  def current_user
    @current_user = current_user_session && current_user_session.user
  end
  
  def logged_in?
    current_user
  end
  
  def authenticate
    unless current_user
      flash[:notice] = "You're not logged in"
      redirect_to new_user_session_path
      return false
    end
  end
  
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"
      redirect_to login_url
      return false
    end
  end
  
  def require_no_user
    if current_user
      store_location
      redirect_to "/"
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
end
