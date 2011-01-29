class DashboardController < ApplicationController
  
  before_filter :require_user, :only => :index
  
  def index
    @body_id = "dashboard"
    @resumes = Resume.where("user_id = ?", current_user.id)
    @profile = Profile.find_by_user_id(current_user.id)
  end
  
end
