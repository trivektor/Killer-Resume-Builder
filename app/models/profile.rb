class Profile < ActiveRecord::Base
  
  belongs_to :user
  
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
  
end
