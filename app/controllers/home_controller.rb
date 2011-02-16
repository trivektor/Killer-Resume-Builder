class HomeController < ApplicationController
  
  def index
    @body_id = "home"
    
    @blogs = Blog.where(:status => :active).order("created_at DESC").limit(1).find(:all)
  end
  
end
