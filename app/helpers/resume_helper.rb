module ResumeHelper
  
  def find_resume_by_id
    begin
      @resume = Resume.find(params[:resume_id])
    rescue
      nil
    end
  end
  
  def manipulatable?
    if @resume
      @resume.user_id == current_user.id 
    else
      false
    end
  end
  
  def verify_ownership
    find_resume_by_id
    
    if !manipulatable?
      redirect_to dashboard_path
      return false
    end
    
    true
  end
  
end