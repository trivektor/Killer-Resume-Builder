class ResumeSettingsController < ApplicationController
  
  before_filter :require_user, :verify_ownership
  
  def update
    
    if manipulatable?
      
      resume_setting = find_resume_settings
      
      resume_setting.update_attributes(params[:resume_setting])
      
      render :json => {:success => 1}
      
    end
    
    
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
  
  def find_resume_settings
    ResumeSetting.find_by_resume_id(params[:resume_id])
  end
  
  def verify_ownership
    find_resume
    
    if !manipulatable?
      render :json => {:success => -1}
      return false
    end
    
    return true
  end
  
end