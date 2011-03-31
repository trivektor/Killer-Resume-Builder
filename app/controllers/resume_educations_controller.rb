class ResumeEducationsController < ApplicationController
  
  include ResumeHelper
  
  before_filter :require_user, :verify_ownership
  
  def new
    @resume_education = ResumeEducation.new
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'education').first
    
    @section_name = section_order.name
  end
  
  def create
    @resume_education = ResumeEducation.new(params[:resume_education])
    @resume_education.resume_id = params[:resume_id]
    if @resume_education.save
      redirect_to edit_resume_path(@resume)
    else
      render :action => :new
    end
  end
  
  def edit
    @resume_education = find_resume_education
    
    section_order = ResumeSectionOrder.where(:resume_id => params[:resume_id], :section => 'education').first
    
    @section_name = section_order.name
  end
  
  def update
    @resume_education = find_resume_education
    if @resume_education.update_attributes(params[:resume_education])
      flash[:notice] = "Education has been updated"
      redirect_to edit_resume_resume_education_path(@resume)
    else
      render :action => :edit
    end
  end
  
  def delete
    ResumeEducation.delete params[:id]
    redirect_to edit_resume_path(@resume)
  end
  
  def order
    orders = params[:order]
    
    weight = orders.count
    
    i = 0
    
    for id in orders
      edu = ResumeEducation.where(:resume_id => params[:resume_id], :id => id).first
      edu.update_attributes(:weight => weight)
      weight -= 1
    end
    
    render :json => {:success => 1}
  end
  
  private
  
  def find_resume_education
    ResumeEducation.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
end
