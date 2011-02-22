class Profile < ActiveRecord::Base
  
  belongs_to :user, :dependent => :destroy, :foreign_key => "user_id"
  
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
  
end
