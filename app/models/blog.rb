class Blog < ActiveRecord::Base
  
  has_many :blog_tags, :dependent => :destroy
  has_many :blog_comments, :dependent => :destroy
  
end
