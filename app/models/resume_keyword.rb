class ResumeKeyword < ActiveRecord::Base
  
  belongs_to :resume
  
  def self.get_keywords(resume)
    keywords = []
    
    if resume.resume_keywords.count > 0
  	   for keyword in resume.resume_keywords
  	       keywords << keyword.keywords
  	   end
  	end
  	
  	keywords
  end
  
end
