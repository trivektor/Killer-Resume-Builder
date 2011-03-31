class ResumeWorkExperiencesController < ApplicationController
  
  include ResumeHelper
  
  before_filter :require_user, :verify_ownership
  
  def new
    @resume_work_experience = ResumeWorkExperience.new
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'work_experience').first
    
    @section_name = section_order.name
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
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'work_experience').first
    
    @section_name = section_order.name
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
  
  def find_resume_work_experience
    ResumeWorkExperience.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
end
