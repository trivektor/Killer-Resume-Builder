class ThoughtsController < ApplicationController
  
  def index
    
  end
  
  def new
    
    success = 0
    
    thought = Thought.new(:user_id => current_user.id, :thought => params[:thought][:content])
    
    if thought.save
      success = 1
    end
    
    respond_to do |format|
      format.json { render :json => {:success => success.to_s} }
    end
  end
  
  def create
  end
  
end