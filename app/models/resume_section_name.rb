class ResumeSectionName < ActiveRecord::Base
  
  belongs_to :resume
  
  def self.create_resume_section_names(resume)
    resume_section_names = resume.resume_section_names
    ["personal_information", "education", "skills", "work_experience", "field_works", "references"].each do |f|
      name = f.sub("_", " ").split(" ").select {|w| w.capitalize! || w}.join(" ")
      resume_section_names.create(
        :section => f,
        :name => name
      )
    end
  end
  
  def self.get_section_names(resume)
    section_names = {}
    
    resume.resume_section_names.each do |s|
      section_names[s.section] = s.name
    end
    
    section_names
  end
  
end
