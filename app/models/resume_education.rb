class ResumeEducation < ActiveRecord::Base
  
  belongs_to :resume, :dependent => :destroy, :foreign_key => :resume_id
  
  validates_presence_of :institution, :begin_date, :end_date, :degree
  
  
  
end
