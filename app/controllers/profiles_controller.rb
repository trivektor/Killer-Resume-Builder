class ProfilesController < ApplicationController
  
  def index
  end
  
  def show
    @user = User.find_by_username(params[:id])
    @profile = Profile.find_by_user_id(@user.id)
    @resumes = Resume.where(:user_id => @user.id, :status => :active).find(:all)
  end
  
  def update
    
    profile = Profile.find_by_user_id(current_user.id)
    
    success = 0
    
    if profile.update_attributes(params[:profile])
      success = 1
    end
    
    respond_to do |format|
      format.json { render :json => {:success => success.to_s} }
    end
    
    session[:user_profile] = Profile.find_by_user_id(current_user.id)
    
    #render :nothing => true
  end
  
end
