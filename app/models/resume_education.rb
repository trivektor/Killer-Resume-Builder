class ResumeEducation < ActiveRecord::Base
  
  belongs_to :resume, :dependent => :destroy
  
  validates_presence_of :institution, :begin_date, :end_date, :degree
  
  
  
end
