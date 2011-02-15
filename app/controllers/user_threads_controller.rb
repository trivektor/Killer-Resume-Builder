class UserThreadsController < ApplicationController
  
  def new
    
  end
  
  def create
    if !params[:user_thread][:content].empty?
      user_thread = UserThread.new(params[:user_thread])
      user_thread.user_id = current_user.id
      user_thread.target_id = params[:user][:target]
      user_thread.thread_type = :profile
      user_thread.save
      
      redirect_to :controller => :profiles, :action => :show, :id => params[:user][:username]
    end
    
  end
  
end