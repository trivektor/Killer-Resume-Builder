class ResumeSectionOrdersController < ApplicationController
  
  before_filter :require_user, :verify_ownership
  
  def update
    
    order = params[:order]
    
    weight = order.count
    
    for id in order
      order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :id => id).first
      order.update_attributes(:weight => weight)
      weight -= 1
    end
    
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
  
  def verify_ownership
    find_resume
    
    if !manipulatable?
      render :json => {:success => -1}
      return false
    end
    
    return true
  end
  
end