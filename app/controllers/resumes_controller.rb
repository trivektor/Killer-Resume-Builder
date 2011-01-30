class ResumesController < ApplicationController
  
  def new
    @resume = Resume.new
  end
  
  def create
    
    #params[:resume].inspect
    
    @resume = Resume.new(:title => params[:resume][:title], :url => params[:resume][:url], 
    :user_id => current_user.id, :status => "active")
            
    if @resume.save
      
      @resume.resume_personal_information = ResumePersonalInformation.new
      @resume.resume_personal_information.save
      
      @resume.resume_skill = ResumeSkill.new
      @resume.resume_skill.save
      
      @resume.resume_field_work = ResumeFieldWork.new
      @resume.resume_field_work.save
      
      @resume.resume_keyword = ResumeKeyword.new
      @resume.resume_keyword.save
      
      @resume.resume_section_order = ResumeSectionOrder.new(:resume_id => @resume.id, 
      :orders => "personal_information/education/skills/work_experience/references/field_works")
      
      @resume.resume_theme = ResumeTheme.new
      @resume.resume_theme.save
      
      @resume.resume_setting = ResumeSetting.new
      @resume.resume_setting.save
      
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
    
  end
  
  def update
    @resume = Resume.find(params[:id])
    if @resume.update_attributes(params[:resume]) 
      @resume.resume_personal_information.update_attributes(params[:resume_personal_information])
      redirect_to :controller => "resumes", :action => :edit, :id => params[:id]
    end
  end
  
end
