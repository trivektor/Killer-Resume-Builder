class PasswordResetsController < ApplicationController
  
  #before_filter :load_user_using_perishable_token, :only => [:edit, :update]
  before_filter :require_no_user
  
  def new
    render
  end
  
  def create
    @user = User.find_by_email(params[:email])
    
    if @user
      #@user.deliver_password_reset_instructions!
      flash[:notice] = "Instructions to reset your password have been emailed to you."
      UserMailer.password_reset_instructions(@user).deliver
    else
      flash[:notice] = "No user was found with that email address"
    end
    
    render :action => :new
  end
  
  def edit
    load_user_using_perishable_token
    render
  end
  
  def update
    load_user_using_perishable_token
    @user.password = params[:user][:password]
    @user.first_name = @user.profile.first_name
    @user.last_name = @user.profile.last_name
    #@user.password_confirmation = params[:user][:password_confirmation]
    
    if @user.save
      flash[:notice] = "Your password has been changed. You can now login using your new password"
      redirect_to login_url
    else
      render :action => :edit
    end
  end
  
  private
  
  def load_user_using_perishable_token
    @user = User.find_by_perishable_token(params[:id])
    unless @user
      flash[:notice] = "Cannot locate your account"
      redirect_to root_url
    end
  end
  
end
