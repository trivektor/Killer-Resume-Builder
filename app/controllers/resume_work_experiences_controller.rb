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
  
  def edit
    if manipulatable? params[:resume_id]
      @resume_work_experience = find_resume_work_experience params[:id], params[:resume_id]
    end
  end
  
  def update
    if manipulatable? params[:resume_id]
      resume_work_experience = find_resume_work_experience params[:id], params[:resume_id]
      if resume_work_experience.update_attributes(params[:resume_work_experience])
        flash[:notice] = "Work experience has been updated"
        redirect_to :controller => :resume_work_experiences, :action => :edit, :id => params[:id]
      end
    end
  end
  
  def manipulatable?(resume_id)
    resume = find_resume resume_id
    resume.user_id == current_user.id 
  end
  
  private
  
  def find_resume(resume_id)
    Resume.find(resume_id)
  end
  
  def find_resume_work_experience(resume_work_experience_id, resume_id)
    ResumeWorkExperience.where(:id => resume_work_experience_id, :resume_id => resume_id).first
  end
  
end
