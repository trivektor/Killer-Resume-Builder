class ResumeWorkExperience < ActiveRecord::Base
  
  belongs_to :resume
  
  validates_presence_of :organization_name
  validates_presence_of :begin_date
  validates_presence_of :end_date
  
end
