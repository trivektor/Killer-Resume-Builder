class Profile < ActiveRecord::Base
  
  belongs_to :user
  
  before_save :capitalize_first_name, :capitalize_last_name
  
  def self.get_location(profile)
    location = []

    location << profile.city unless profile.city.blank?
    
    location << profile.state unless profile.state.blank?
    
    location << profile.country unless profile.country.blank?
    
    location << profile.postal_code unless profile.postal_code.blank?
          
    location
  end
  
  def self.missing_fields(profile)
    missing = []
    
    if profile.first_name.blank?
      missing << "first name"
    end
    
    if profile.last_name.blank?
      missing << "last name"
    end
    
    if profile.job_title.blank?
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
