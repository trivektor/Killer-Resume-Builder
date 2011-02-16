class PopulateAuthorSlugsInBlogs < ActiveRecord::Migration
  def self.up
    blogs = Blog.find(:all)
    
    for blog in blogs
      author = blog.author
      author_slug = author.sub(" ", "-").downcase
      blog.update_attributes(:author_slug => author_slug)
    end
  end

  def self.down
  end
end
