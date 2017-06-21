class ResumeFieldWork < ActiveRecord::Base
  
  belongs_to :resume, :foreign_key => :resume_id
  
end
