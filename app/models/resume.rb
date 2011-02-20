class Resume < ActiveRecord::Base
  
  has_one :resume_personal_information, :dependent => :delete
  has_one :resume_section_order, :dependent => :delete
  has_one :resume_field_work, :dependent => :delete
  has_one :resume_skill, :dependent => :delete
  has_one :resume_theme, :dependent => :delete
  has_one :resume_setting, :dependent => :delete
  
  has_many :resume_educations, :dependent => :delete_all, :order => "weight DESC"
  has_many :resume_keywords, :dependent => :delete_all
  has_many :resume_work_experiences, :dependent => :delete_all
  has_many :resume_references, :dependent => :delete_all, :order => "weight DESC"
  has_many :resume_section_names, :dependent => :delete_all
  has_many :resume_hidden_fields, :dependent => :delete_all
  
  belongs_to :user
  
  validates_presence_of :url, :title
  
  accepts_nested_attributes_for :resume_personal_information, :resume_skill, :resume_field_work, :resume_educations
  
end
