class ResumesController < ApplicationController
  
  def new
    @resume = Resume.new
  end
  
  def create
    
    #params[:resume].inspect
    
    @resume = Resume.new(:title => params[:resume][:title], :url => params[:resume][:url], 
    :user_id => current_user.id, :status => "active")
            
    if @resume.save
      
      @resume.resume_personal_information = ResumePersonalInformation.create
      
      @resume.resume_skill = ResumeSkill.create
      
      @resume.resume_field_work = ResumeFieldWork.create
      
      @resume.resume_keyword = ResumeKeyword.create
      
      @resume.resume_section_order = ResumeSectionOrder.create(:resume_id => @resume.id, 
      :orders => "personal_information/education/skills/work_experience/references/field_works")
      
      @resume.resume_theme = ResumeTheme.create
      
      @resume.resume_setting = ResumeSetting.create
      
      for f in ["personal_information", "education", "skills", "work_experience", "field_works", "references"]
        name = f.sub("_", " ").split(" ").select {|w| w.capitalize! || w}.join(" ")
        @resume.resume_section_names.create!(
          :resume_id => @resume.id,
          :section => f,
          :name => name
        )
      end
      
      
      redirect_to :controller => "dashboard", :action => "index"
    else
      render :action => "new"
    end
  end
  
  def show
    @resume = Resume.find_by_url(params[:url])
  end
  
  def edit
    
    @body_id = "resume_edit"
    
    @resume = Resume.find(params[:id])
    
    @personal_info = @resume.resume_personal_information
    
    @skill = @resume.resume_skill
    
    @field_work = @resume.resume_field_work
    
    @section_names = {}
    
    @resume.resume_section_names.each do |s|
      @section_names[s.section] = s.name
    end
    
    @section_order = @resume.resume_section_order.orders.split("/")
    
  end
  
  def update
    @resume = Resume.find(params[:id])
    if @resume.update_attributes(params[:resume]) 
      @resume.resume_personal_information.update_attributes(params[:resume_personal_information])
      @resume.resume_skill.update_attributes(params[:resume_skill])
      @resume.resume_field_work.update_attributes(params[:resume_field_work])
      flash[:notice] = "Your resume has been updated"
      redirect_to :controller => "resumes", :action => :edit, :id => params[:id]
      
    end
  end
  
end
