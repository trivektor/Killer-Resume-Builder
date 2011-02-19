class ResumeEducation < ActiveRecord::Base
  
  belongs_to :resume
  
  validates_presence_of :institution, :begin_date, :end_date, :degree
  
end
