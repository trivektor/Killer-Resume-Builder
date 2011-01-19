class UserSessionsController < ApplicationController
  
  def new 
    @user_session = UserSession.new
  end
  
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if (@user_session.save)
      redirect_to :controller => "dashboard", :action => "index"
    else
      render :action => :new
    end
  end
  
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    #current_user_session.destroy
    redirect_to "/"
  end
  
end
