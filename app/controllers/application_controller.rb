class ApplicationController < ActionController::Base
  
  protect_from_forgery
  
  before_filter do
    if logged_in?
      user_profile
    end
  end
  
  helper_method :current_user_session, :current_user, :logged_in?, :user_profile, :get_countries, :get_job_categories, :get_job_industries
  
  protected 
  
  def get_countries
    countries = Country.find(:all)
    countries_hash = {}
    for country in countries
      countries_hash[country.printable_name] = country.id
    end
    countries_hash.sort
  end
  
  def get_job_industries
    industries = JobIndustry.where(:status => :active).find(:all)
    industries_hash = {}
    for industry in industries
      industries_hash[industry.industry] = industry.id
    end
    industries_hash.sort
  end
  
  def get_job_categories
    categories = JobCategory.where(:status => :active).find(:all)
    categories_hash = {}
    for category in categories
      categories_hash[category.category_name] = category.id
    end
    categories_hash.sort
  end
  
  def user_profile
    if session[:user_profile].nil?
      session[:user_profile] = Profile.find_by_user_id(current_user.id)
    end
    
    @profile = session[:user_profile]
  end
  
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
      redirect_to root_url
      return false
    end
  end
  
  def store_location
    session[:return_to] = request.fullpath
  end
  
end
