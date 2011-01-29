class Resume < ActiveRecord::Base
  
  has_one :resume_personal_information
  has_one :resume_keyword
  has_one :resume_section_order
  has_one :resume_field_work
  has_one :resume_skills
  
  has_many :resume_educations 
  has_many :resume_work_experiences
  has_many :resume_references
  has_many :resume_section_names
  has_many :resume_hidden_fields
  
  belongs_to :user
  
  validates_presence_of :url, :title
  
end
