class ActivationsController < ApplicationController
  
  before_filter :require_no_user, :only => [:new, :create]
  
  def new
    @user = User.find_using_perishable_token(params[:activation_code], 1.week) || (raise Exception)
    raise Exception if @user.active?
  end
  
  def invalid_activation_code
    
  end
  
  def activated
    
  end
  
  def create
    @user = User.find_by_perishable_token(params[:activation_code])
    
    if @user.nil? then
      redirect_to invalid_activation_code_url
      return
    end
    
    if @user.active then
      redirect_to activated_url
      return
    end
    
    if @user.activate!
      flash[:notice] = "Your account has been activated. You can now login"
      redirect_to login_url
      return
    else
      render :action => :new
    end
  end
  
end
