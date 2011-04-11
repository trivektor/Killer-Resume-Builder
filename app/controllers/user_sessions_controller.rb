class UserSessionsController < ApplicationController
  
  def new 
    @user_session = UserSession.new
  end
  
  def create
    params[:user_session][:remember_me] = true
    @user_session = UserSession.new(params[:user_session])
    
    if (@user_session.save)
      redirect_to :controller => "dashboard", :action => "index"
    else
      render :action => :new
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy unless @user_session.nil?
    #current_user_session.destroy
    reset_session
    redirect_to "/"
  end
  
end
