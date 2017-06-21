class DashboardController < ApplicationController
  
  before_filter :require_user, :only => :index
  
  def index 
    @resumes = current_user.resumes
    
    @popular_resumes = Resume.get_popular_resumes(current_user)
    
    @resume_viewers = Resume.get_resume_viewers(@resumes, current_user)
    
    @missing = Profile.missing_fields(current_user.profile)
  end
  
  
  
end
