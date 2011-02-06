class Resume < ActiveRecord::Base
  
  has_one :resume_personal_information, :dependent => :destroy
  has_one :resume_keyword, :dependent => :destroy
  has_one :resume_section_order, :dependent => :destroy
  has_one :resume_field_work, :dependent => :destroy
  has_one :resume_skill, :dependent => :destroy
  has_one :resume_theme, :dependent => :destroy
  has_one :resume_setting, :dependent => :destroy
  
  has_many :resume_educations, :dependent => :destroy
  has_many :resume_work_experiences, :dependent => :destroy
  has_many :resume_references, :dependent => :destroy
  has_many :resume_section_names, :dependent => :destroy
  has_many :resume_hidden_fields, :dependent => :destroy
  
  belongs_to :user
  
  validates_presence_of :url, :title
  
  accepts_nested_attributes_for :resume_personal_information, :resume_skill, :resume_field_work, :resume_educations
  
end
