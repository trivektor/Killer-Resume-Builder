class UsersController < ApplicationController
  
  layout "signup"
  
  before_filter :setup
  
  def setup
    @body_id = "signup"
  end
  
  def new
    
    @user = User.new
    
    #params[:body_id] = 'signup' 
    
  end
  
  def create
    @user = User.new(params[:user])
    
    if @user.save
      @user.profile = Profile.new
      @user.profile.save
      
      redirect_to :controller => "dashboard", :action => "index"
      
    else
      render :action => "new"
    end
    
  end
  
end
