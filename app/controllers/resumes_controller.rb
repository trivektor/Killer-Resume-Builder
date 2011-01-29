class ResumesController < ApplicationController
  
  def new
    @resume = Resume.new
  end
  
  def create
    
    #params[:resume].inspect
    
    @resume = Resume.new(:title => params[:resume][:title], :url => params[:resume][:url], 
    :user_id => current_user.id, :status => "active")
            
    if @resume.save
      
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
    @resume = Resume.find(params[:id]);
  end
  
end
