class BlogsController < ApplicationController
  
  def index
  end
  
  def show
    @body_id = "blog_details"
    
    @post = Blog.find_by_slug(params[:id])
    
  end
  
  def author
  end
  
  def tag
    
  end
  
end