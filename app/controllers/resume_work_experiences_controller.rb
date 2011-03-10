class ResumeWorkExperiencesController < ApplicationController
  
  before_filter :require_user, :verify_ownership
  
  def new
    @resume_work_experience = ResumeWorkExperience.new
    
    @section_name = find_section_name
  end
  
  def create
    @resume_work_experience = ResumeWorkExperience.new(params[:resume_work_experience])
    @resume_work_experience.resume_id = params[:resume_id]
    if @resume_work_experience.save
      redirect_to edit_resume_path(@resume)
    else
      render :action => :new
    end
  end
  
  def edit
    @resume_work_experience = find_resume_work_experience
    
    @section_name = find_section_name
  end
  
  def update
    @resume_work_experience = find_resume_work_experience
    if @resume_work_experience.update_attributes(params[:resume_work_experience])
      flash[:notice] = "Work experience has been updated"
      redirect_to edit_resume_resume_work_experience_path(@resume)
    else
      render :action => :edit
    end
  end
  
  def delete
    ResumeWorkExperience.delete(params[:id])
    redirect_to edit_resume_path(@resume)
  end
  
  def order
    orders = params[:order]
    
    weight = orders.count
    
    i = 0
    
    for id in orders
      exp = ResumeWorkExperience.where(:resume_id => params[:resume_id], :id => id).first
      exp.update_attributes(:weight => weight)
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
  
  def find_resume_work_experience
    ResumeWorkExperience.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
  def find_section_name
    section_name = ResumeSectionName.where(:resume_id => params[:resume_id], :section => "work_experience").first
    section_name.name
  end
  
  def verify_ownership
    find_resume
    
    if !manipulatable?
      redirect_to dashboard_path
      return false
    end
    
    true
  end
  
end
