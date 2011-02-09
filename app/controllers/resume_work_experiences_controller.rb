class ResumeWorkExperiencesController < ApplicationController
  
  def index
  end
  
  def new
    @resume_work_experience = ResumeWorkExperience.new
  end
  
  def create
    @resume_work_experience = ResumeWorkExperience.new(params[:resume_work_experience])
    @resume_work_experience.resume_id = params[:resume_id]
    
    if @resume_work_experience.save
      redirect_to :controller => :resumes, :action => :edit, :id => params[:resume_id]
    end
    
  end
  
end
