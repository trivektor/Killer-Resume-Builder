class ResumeHiddenFieldsController < ApplicationController
  
  before_filter do
    find_resume
    render :json => {:success => -1} unless manipulatable?
  end
  
  def update_section
    
    type = params[:type].to_s
    
    if (type == "enable")
      hidden_field = find_resume_hidden_field
      hidden_field.destroy unless hidden_field.nil?
    else
      hidden_field = ResumeHiddenField.new(:resume_id => params[:resume_id], :hidden_field => params[:hidden_field])
      hidden_field.save
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
  
  def find_resume_hidden_field
    begin
      ResumeHiddenField.where(:resume_id => params[:resume_id], :hidden_field => params[:hidden_field]).first
    rescue
      nil
    end
  end
  
  
end
