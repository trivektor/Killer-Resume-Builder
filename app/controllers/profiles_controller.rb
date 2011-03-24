class ProfilesController < ApplicationController
  
  def show
    @user = User.find_by_username(params[:id])
    @profile = @user.profile
    
    @location = Profile.get_location(@profile)
    
    @resumes = @user.resumes
    
    @thoughts = @user.thoughts
    
    @shouts = UserThread.find_profile_shouts(@profile)
    
    @shouters = UserThread.find_shouters(@shouts)
    
    @user_thread = UserThread.new
  end
  
  def update
    
    profile = current_user.profile
    
    success = 0
    
    if profile.update_attributes(params[:profile])
      success = 1
    end
    
    respond_to do |format|
      format.json { render :json => {:success => success.to_s} }
    end
    
    update_profile_session
  end
  
  def upload_photo
    render :layout => "photo_upload"
  end
  
  def process_upload_photo
    
    uploaded_photo = DataFile.save(params[:upload])
    
    profile = Profile.find_by_user_id(current_user.id)
    
    profile.update_attributes(:photo => uploaded_photo)
    profile.save
    
    update_profile_session
    
    render :layout => "photo_upload"
    
  end
  
  def hide_profile_notice
    profile = current_user.profile
    profile.update_attributes(:hide_profile_notification => true)
        
    update_profile_session
        
    render :json => {:success => 1}
  end
  
  private 
  
  def update_profile_session
    session[:user_profile] = Profile.find_by_user_id(current_user.id)
  end
  
end
