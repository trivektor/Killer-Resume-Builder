class ResumeSectionOrder < ActiveRecord::Base
  
  belongs_to :resume
  
  def self.create_resume_section_order(resume)
    resume_section_orders = resume.resume_section_orders
    resume_section_orders.create(:section => 'personal_information', :name => 'Personal Information')
    resume_section_orders.create(:section => 'education', :name => 'Education')
    resume_section_orders.create(:section => 'skills', :name => 'Skills')
    resume_section_orders.create(:section => 'work_experience', :name => 'Work Experience')
    resume_section_orders.create(:section => 'references', :name => 'References')
    resume_section_orders.create(:section => 'field_works', :name => 'Field Works')
  end
  
  def self.get_section_order(resume)
    section_orders = []
    resume.resume_section_orders.each do |section|
      section_orders << section.section
    end
    section_orders
  end
  
  def self.get_section_names(resume)
    section_names = {}
    
    resume.resume_section_orders.each do |s|
      section_names[s.section] = s.name
    end
    
    section_names
  end
  
end
