class ResumeSectionNamesController < ApplicationController
  
  before_filter do
    find_resume
    render :json => {:success => -1} unless manipulatable?
  end
  
  def update
    resume_section_name = find_resume_section_name
    
    resume_section_name.update_attributes(:section => params[:resume_section_name][:section], 
    :name => params[:resume_section_name][:name])
    
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
  
  def find_resume_section_name
    ResumeSectionName.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
end
