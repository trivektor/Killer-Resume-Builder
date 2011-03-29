class ResumeHiddenField < ActiveRecord::Base
  
  belongs_to :resume
  
  def self.get_hidden_fields(resume)
    hidden_fields = []
    
    if resume.resume_hidden_fields.count > 0
  	  for hfield in resume.resume_hidden_fields
  	    hidden_fields << hfield.hidden_field
	    end
	  end
	  
	  hidden_fields
  end
  
end
