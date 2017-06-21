class ThoughtsController < ApplicationController
  
  before_filter :require_user
  
  def create
    
    success = 0
    
    thought = Thought.new(:user_id => current_user.id, :thought => params[:thought][:content])
    
    if thought.save
      success = 1
    end
    
    respond_to do |format|
      format.json { render :json => {:success => success.to_s} }
    end
    
  end
  
end