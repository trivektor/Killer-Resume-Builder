class ResumeReferencesController < ApplicationController
  
  def new
    @resume_reference = ResumeReference.new
  end
  
  def create
    if manipulatable? params[:resume_id]
      @resume_reference = ResumeReference.new(params[:resume_reference])
      @resume_reference.resume_id = params[:resume_id]
      if @resume_reference.save
        redirect_to :controller => :resumes, :action => :edit, :id => params[:resume_id]
      else
        render :action => :new
      end
    end
  end
  
  def edit
    
  end
  
  def update
    
  end
  
  def delete
  end
  
  private
  
  def manipulatable?(resume_id)
    resume = find_resume resume_id
    resume.user_id == current_user.id 
  end
  
  def find_resume(resume_id)
    Resume.find(resume_id)
  end
  
  def find_resume_education(resume_education_id, resume_id)
    ResumeEducation.where(:id => resume_education_id, :resume_id => resume_id).first
  end
  
end
