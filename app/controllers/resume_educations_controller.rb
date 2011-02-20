class ResumeEducationsController < ApplicationController
  
  before_filter do
    find_resume
    redirect_to dashboard_path unless manipulatable?
  end
  
  def new
    @resume_education = ResumeEducation.new
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
  end
  
  def update
    resume_education = find_resume_education
    if resume_education.update_attributes(params[:resume_education])
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
  
  def find_resume_education
    ResumeEducation.where(:id => params[:id], :resume_id => params[:resume_id]).first
  end
  
end
