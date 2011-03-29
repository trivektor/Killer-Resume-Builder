class UsersController < ApplicationController
  
  layout :signup
  
  before_filter :setup
  
  def setup
    @body_id = :signup
  end
  
  def new
    @user = User.new
    
    render :layout => "signup"
  end
  
  def create
    # @user = User.new(params[:user])
    #     
    #     if @user.save
    #       @user.profile = Profile.new(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name])
    #       @user.profile.save
    #       
    #       redirect_to dashboard_path
    #       
    #     else
    #       render :layout => "signup", :action => :new
    #     end
    
    @user =  User.new(params[:user])
    if @user.save_without_session_maintenance
      @user.profile = Profile.new(:first_name => params[:user][:first_name], :last_name => params[:user][:last_name])
      @user.profile.save
      @user.deliver_activation_instructions!
      flash[:notice] = "Your account has been created. Please check your e-mail for your account activation instructions!"
      redirect_to registration_complete_url
    else
      render :layout => "signup", :action => :new
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
  
  def registration_complete
    render :layout => "application"
  end
  
end
