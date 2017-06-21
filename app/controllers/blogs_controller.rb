class BlogsController < ApplicationController
  
  def index
    
    @posts = Blog.where(:status => :active).order("created_at DESC")
    
    @authors = []
    
    authors = Blog.select(:author, :author_slug)
    
    for author in authors
      @authors << {:name => author.author, :slug => author.author_slug}
    end
    
  end
  
  def show
    
    @post = Blog.find_by_slug(params[:id])
    
  end
  
  def author
    
    @posts = Blog.where(:status => :active, :author_slug => params[:name]).order("created_at DESC").find(:all)
    
  end
  
  def tag
    
    #@posts = Blog.where(:status => :active, :author_slug => params[:name]).order("created_at DESC").find(:all)
    
  end
  
end