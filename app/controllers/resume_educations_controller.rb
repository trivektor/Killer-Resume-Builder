class ResumeEducationsController < ApplicationController
  
  def new
    @resume_education = ResumeEducation.new
  end
  
  def create
    @resume_education = ResumeEducation.new(params[:resume_education])
    @resume_education.resume_id = params[:resume_id]
    if @resume_education.save
      redirect_to :controller => :resumes, :action => :edit, :id => params[:resume_id]
    else
      render :action => :new
    end
  end
  
  def edit
    if manipulatable? params[:resume_id]
      @resume_education = find_resume_education params[:id], params[:resume_id]
    end
  end
  
  def update
    if manipulatable? params[:resume_id]
      @resume_education = find_resume_education params[:id], params[:resume_id]
      if @resume_education.update_attributes params[:resume_education]
        flash[:notice] = "Education has been updated"
        redirect_to :controller => :resume_educations, :action => :edit, :id => params[:id]
      else
        render :action => :edit
      end
    end
  end
  
  def delete
    if manipulatable? params[:resume_id]
      ResumeEducation.delete params[:id]
      redirect_to :controller => :resumes, :action => :edit, :id => params[:resume_id]
    end
  end
  
  def show
    redirect_to :controller => :resumes, :action => :edit, :id => params[:resume_id]
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
