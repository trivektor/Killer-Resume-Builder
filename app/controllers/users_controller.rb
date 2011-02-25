class UsersController < ApplicationController
  
  layout :signup
  
  before_filter :setup
  
  def setup
    @body_id = :signup
  end
  
  def new
    @user = User.new 
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      @user.profile = Profile.new
      @user.profile.save
      
      redirect_to dashboard_path
      
    else
      render :action => :new
    end
    
  end
  
  def edit
    @user = current_user
    
    @body_id = :change_password
    
    render :layout => "application"
  end
  
  def update
    @user = current_user
    
    if @user.update_attributes(params[:user])
      flash[:notice] = "Your account has been updated"
      
      redirect_to dashboard_path
    else
      @body_id = :change_password
      
      render :layout => "application", :action => :edit
    end
  end
  
end
