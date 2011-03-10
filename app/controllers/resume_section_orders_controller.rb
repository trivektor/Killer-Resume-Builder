class ResumeSectionOrdersController < ApplicationController
  
  before_filter :require_user, :verify_ownership
  
  def update
    
    sections = {
      1 => "personal_information",
      2 => "education",
      3 => "skills",
      4 => "work_experience",
      5 => "references",
      6 => "field_works",
      7 => "keywords"
    }
    
    section_orders = []
    
    for order in params[:order]
      section_orders << sections[order.to_i]
    end
    
    resume_section_order = ResumeSectionOrder.find_by_resume_id(params[:resume_id])
    
    resume_section_order.update_attributes(:orders => section_orders.join("/"))
    
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