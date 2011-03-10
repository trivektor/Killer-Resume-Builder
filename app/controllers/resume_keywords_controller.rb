class ResumeKeywordsController < ApplicationController
  
  before_filter :require_user, :verify_ownership
  
  def create
    
    keyword = ResumeKeyword.create(:resume_id => params[:resume_id], :keywords => params[:resume_keyword])
    
    render :json => {:success => 1, :keyword => params[:resume_keyword], :id => keyword.id}
  end
  
  def destroy
    ResumeKeyword.delete(params[:id])
    
    render :json => {:success => 1}
  end
  
  private
  
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
  
  def find_resume_keywords
    ResumeKeyword.find_by_resume_id(params[:resume_id])
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