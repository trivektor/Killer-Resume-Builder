class DashboardController < ApplicationController
  
  before_filter :require_user, :only => :index
  
  def index
    @body_id = "dashboard"
    @resumes = Resume.where("user_id = ?", current_user.id).order("created_at DESC")
  end
  
end
