class ResumesController < ApplicationController
  
  before_filter :require_user, :except => [:show]
  before_filter :verify_ownership, :except => [:show, :new, :create]
  
  def new
    @resume = Resume.new
  end
  
  def create
    
    @resume = Resume.new(:title => params[:resume][:title], :url => params[:resume][:url], :user_id => current_user.id)
            
    if @resume.save
      
      @resume.resume_personal_information = ResumePersonalInformation.create
      
      @resume.resume_skill = ResumeSkill.create
      
      @resume.resume_field_work = ResumeFieldWork.create
      
      @resume.resume_theme = ResumeTheme.create(:theme_id => Theme.default_theme.id)
      
      @resume.resume_setting = ResumeSetting.create
      
      ResumeSectionOrder.create_resume_section_order(@resume)
      
      redirect_to dashboard_path and return
    else
      render :action => :new
    end
  end
  
  def show
    @resume = Resume.find_by_url(params[:url])
    
    if !@resume.nil?
      @theme = Theme.find(@resume.resume_theme.theme_id)
      
      @section_names = ResumeSectionOrder.get_section_names(@resume)
      
      @section_order = ResumeSectionOrder.get_section_order(@resume)
      
      @keywords = ResumeKeyword.get_keywords(@resume)
      
    	@field_works = @resume.resume_field_work.field_works
    	
    	@hidden_fields = ResumeHiddenField.get_hidden_fields(@resume)
  	  
  	  update_analytics(@resume)
      
      render :layout => "themes/#{@theme.slug}"
    else
      redirect_to root_url and return
    end
  end
  
  def edit
    @section_names = ResumeSectionOrder.get_section_names(@resume)
    
    @settings = @resume.resume_setting
    
    @field_works = @resume.resume_field_work.field_works
  	
  	@hidden_fields = ResumeHiddenField.get_hidden_fields(@resume)
  end
  
  def update
    if @resume.update_attributes(params[:resume])
      flash[:notice] = "Your resume has been updated"
      redirect_to edit_resume_path(@resume)
    else
      render :action => :edit
    end
  end
  
  def delete
    @resume.destroy
    redirect_to dashboard_path and return
  end
  
  def select_theme
    @themes = Theme.get_all_themes
    render :layout => "theme_selector"
  end
  
  private
  
  def update_analytics(resume)
    user_agent = UserAgent.parse(request.user_agent)
	  
	  resume.visitor_infos.create(:browser => user_agent[2].product, :version => user_agent.version, :platform => user_agent[0].comment.join(" "), :ip_address => request.remote_addr, :domain_name => request.host)
	  
	  user_id = logged_in? ? current_user.id : 0
	  
	  resume.update_attributes(:views => resume.views + 1) unless (user_id != 0 && user_id == resume.user.id)
	  
	  resume.resume_viewers.create(:user_id => user_id)
  end
  
  def verify_ownership
    
    begin
      @resume = Resume.find(params[:id])
      
      if !@resume.user_id == current_user.id
        redirect_to dashboard_path
        return false
      end
      
      return true
    rescue
      redirect_to dashboard_path
      return false
    end
      
  end
 
end
