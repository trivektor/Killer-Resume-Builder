class ResumeWorkExperience < ActiveRecord::Base
  
  belongs_to :resume
  
  validates_presence_of :organization_name, :begin_date
  
end
