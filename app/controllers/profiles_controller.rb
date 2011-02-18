class ProfilesController < ApplicationController
  
  def show
    @user = User.find_by_username(params[:id])
    @profile = Profile.find_by_user_id(@user.id)
    @resumes = Resume.where(:user_id => @user.id, :status => :active).find(:all)
    
    @shouts = UserThread.where(:target_id => @profile.user_id, :thread_type => :profile).find(:all)
    
    shouter_ids = []
    
    for shout in @shouts
      shouter_ids << shout.user_id 
    end
    
    @shouters = {}
    
    users = User.where(:id => shouter_ids).includes(:profile)
    
    for u in users
      @shouters[u.id] = u.username
    end
    
    @user_thread = UserThread.new
    
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
  
  def upload_photo
    render :layout => "photo_upload"
  end
  
  def process_upload_photo
    
    uploaded_photo = DataFile.save(params[:upload])
    
    profile = Profile.find_by_user_id(current_user.id)
    
    profile.update_attributes(:photo => uploaded_photo)
    profile.save
    
    session[:user_profile] = Profile.find_by_user_id(current_user.id)
    
    render :layout => "photo_upload"
    
  end
  
  def crop_photo
    
  end
  
  
end
