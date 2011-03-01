class Profile < ActiveRecord::Base
  
  belongs_to :user
  
  before_save :capitalize_first_name, :capitalize_last_name
  
  def self.missing_fields(profile)
    missing = []
    
    if profile.first_name.empty?
      missing << "first name"
    end
    
    if profile.last_name.empty?
      missing << "last name"
    end
    
    if profile.job_title.empty?
      missing << "job title"
    end
    
    missing
  end
  
  private
  
  def capitalize_first_name
    self.first_name = self.first_name.capitalize
  end
  
  def capitalize_last_name
    self.last_name = self.last_name.capitalize
  end
  
end
