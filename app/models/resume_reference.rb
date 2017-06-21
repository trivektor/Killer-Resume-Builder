class ResumeReference < ActiveRecord::Base
  
  belongs_to :resume
  
  validates_presence_of :name, :title, :organization, :email
  
end
