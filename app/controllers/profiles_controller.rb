class ProfilesController < ApplicationController
  
  def index
  end
  
  def show
    @user = User.find_by_username(params[:id])
    @profile = Profile.find_by_user_id(@user.id)
  end
  
  def update
    
    profile = Profile.find_by_user_id(current_user.id)
    
    if profile.update_attributes(params[:profile])
      puts 1
    else
      puts 0
    end
    
    render :nothing => true
  end
  
end
