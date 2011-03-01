class Resume < ActiveRecord::Base
  
  has_one :resume_personal_information, :dependent => :delete
  has_one :resume_section_order, :dependent => :delete
  has_one :resume_field_work, :dependent => :delete
  has_one :resume_skill, :dependent => :delete
  has_one :resume_theme, :dependent => :delete
  has_one :resume_setting, :dependent => :delete
  
  has_many :resume_educations, :dependent => :delete_all, :order => "weight DESC"
  has_many :resume_keywords, :dependent => :delete_all
  has_many :resume_work_experiences, :dependent => :delete_all, :order => "weight DESC"
  has_many :resume_references, :dependent => :delete_all, :order => "weight DESC"
  has_many :resume_section_names, :dependent => :delete_all
  has_many :resume_hidden_fields, :dependent => :delete_all
  has_many :resume_viewers, :dependent => :delete_all, :order => "created_at DESC"
  
  belongs_to :user
  
  validates_presence_of :url, :title
  
  accepts_nested_attributes_for :resume_personal_information, :resume_skill, :resume_field_work, :resume_educations
  
  before_save :prep_url
  
  private
  
  def prep_url
    self.url = to_slug(self.url).downcase
  end
  
  def to_slug(string)
    #strip the string
    ret = string.strip

    #blow away apostrophes
    ret.gsub! /['`]/,""

    # @ --> at, and & --> and
    ret.gsub! /\s*@\s*/, " at "
    ret.gsub! /\s*&\s*/, " and "

    #replace all non alphanumeric, underscore or periods with underscore
     ret.gsub! /\s*[^A-Za-z0-9\.\-]\s*/, '-'  

     #convert double underscores to single
     ret.gsub! /_+/,"-"

     #strip off leading/trailing underscore
     ret.gsub! /\A[_\.]+|[_\.]+\z/,""

     ret
  end
  
  
end
