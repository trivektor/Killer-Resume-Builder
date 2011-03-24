class UserThreadsController < ApplicationController
  
  before_filter :require_user
  before_filter :verify_ownership, :except => [:create, :report_comment]
  
  def new
    
  end
  
  def create
    #TODO: more rigorous checking to make sure that params[:user][:target] cannot be tinkered
    if !params[:user_thread][:content].empty?
      user_thread = UserThread.new(params[:user_thread])
      user_thread.user_id = current_user.id
      user_thread.target_id = params[:user][:target]
      user_thread.thread_type = :profile
      user_thread.save
      
      redirect_to :controller => :profiles, :action => :show, :id => params[:user][:username]
    end
    
  end
  
  def report_comment
    user_thread = find_user_thread
    user_thread.update_attributes({:reported => 1})
    render :json => {:success => 1}
  end
  
  def remove_comment
    @user_thread.destroy
    render :json => {:success => 1}
  end
  
  private
  
  def find_user_thread
    begin
      user_thread = UserThread.find(params[:id])
    rescue
      user_thread = nil
    end
  end
  
  def verify_ownership
    @user_thread = find_user_thread
    
    return false unless @user_thread.nil?
    
    @user_thread.user_id == current_user.id
  end
  
end