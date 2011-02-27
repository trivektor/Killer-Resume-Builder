class ResumeThemesController < ApplicationController
  
  before_filter do
    find_resume
    render :json => {:error => -1} unless manipulatable?
  end
  
  def update
    
    resume_theme = find_resume_theme
    
    resume_theme.update_attributes(params[:resume_theme])
    
    render :json => {:succes => 1}
  end
  
  def manipulatable?
    if @resume
      @resume.user_id == current_user.id 
    else
      false
    end
  end
  
  def find_resume
    begin
      @resume = Resume.find(params[:resume_id])
    rescue
      nil
    end
  end
  
  def find_resume_theme
    ResumeTheme.find_by_resume_id(params[:resume_id])
  end
  
end
