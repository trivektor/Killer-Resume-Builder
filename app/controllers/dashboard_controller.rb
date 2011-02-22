class DashboardController < ApplicationController
  
  before_filter :require_user, :only => :index
  
  def index
    @body_id = "dashboard"
    
    @resumes = get_resumes
    
    @popular_resumes = get_popular_resumes
    
    @resume_viewers = get_resume_viewers
    
    @missing = Profile.missing_fields(current_user.profile)
  end
  
  private 
  
  def get_resumes
    Resume.where("user_id = ?", current_user.id).order("created_at DESC")
  end
  
  def get_popular_resumes
    Resume.where("user_id = ?", current_user.id).order("views DESC").limit(5)
  end
  
  def get_resume_viewers
    resume_ids = []
    
    for resume in @resumes
      resume_ids << resume.id
    end
    
    resume_viewers = ResumeViewer.where(:resume_id => resume_ids).find(:all)
    
    resume_viewer_ids = []
    
    for resume_viewer in resume_viewers
      resume_viewer_ids << resume_viewer.id
    end
    
    users = User.includes(:profile).where(:id => resume_viewer_ids).limit(5).find(:all)
    
  end
  
end
