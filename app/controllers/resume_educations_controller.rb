class ResumeEducationsController < ApplicationController
  
  def new
    @resume = Resume.find params[:resume_id]
    @resume_education = ResumeEducation.new
  end
  
  def create
    @resume_education = ResumeEducation.new params[:resume_education]
    if @resume_education.save
      flash[:error] = "blah"
    else
      flash[:notice] = "bloh"s
    end
  end
  
end
