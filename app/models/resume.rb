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
  has_many :visitor_infos, :dependent => :delete_all
  
  belongs_to :user
  
  validates_length_of :url, :minimum => 4
  validates_uniqueness_of :url
  validates_presence_of :title
  
  accepts_nested_attributes_for :resume_personal_information, :resume_skill, :resume_field_work, :resume_educations
  
  before_save :prep_url
  
  def self.get_popular_resumes(user)
    self.where("user_id = ?", user.id).order("views DESC").limit(5)
  end
  
  def self.get_resume_viewers(resumes, user)
    resume_ids = []
    
    resumes.each do |resume|
      resume_ids << resume.id
    end
    
    resume_viewers = ResumeViewer.where(:resume_id => resume_ids).find(:all)
    
    resume_viewer_ids = []
    
    resume_viewers.each do |resume_viewer|
      resume_viewer_ids << resume_viewer.id unless resume_viewer.user_id == user.id
    end
    
    viewers = User.includes(:profile).where(:id => resume_viewer_ids).limit(5).find(:all)
    viewers
  end
  
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
