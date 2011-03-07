class ProfilesController < ApplicationController
  
  def show
    @user = User.find_by_username(params[:id])
    @profile = Profile.find_by_user_id(@user.id)
    
    @location = get_location(@profile)
    
    @resumes = Resume.where(:user_id => @user.id, :status => :active).find(:all)
    
    @thoughts = Thought.where(:user_id => @user.id).order("created_at DESC").find(:all)
    
    @shouts = UserThread.where(:target_id => @profile.user_id, :thread_type => :profile).order("created_at DESC").find(:all)
    
    shouter_ids = []
    
    for shout in @shouts
      shouter_ids << shout.user_id 
    end
    
    @shouters = {}
    
    users = User.where(:id => shouter_ids).includes(:profile)
    
    for u in users
      @shouters[u.id] = {:username => u.username, :photo => u.profile.photo}
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
    
    update_profile_session
    
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
    
    update_profile_session
    
    render :layout => "photo_upload"
    
  end
  
  def hide_profile_notice
    # profile = current_user.profile
    #     profile.update_attributes(:hide_profile_notification => 1)
    #     
    #     update_profile_session
    #     
    render :json => {:success => 1}
  end
  
  private 
  
  def update_profile_session
    session[:user_profile] = Profile.find_by_user_id(current_user.id)
  end
  
  def get_location(profile)
    location = []
    if !profile.city.empty?
      location << profile.city
    end
    
    if !profile.state.empty?
      location << profile.state
    end
    
    if !profile.country_id.nil?
      begin
        country = Country.find(profile.country_id)
        location << country.printable_name
      rescue
      end
    end
    
    if !profile.postal_code.empty?
      location << profile.postal_code
    end
    
    location
  end
  
end
