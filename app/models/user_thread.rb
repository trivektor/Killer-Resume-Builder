class UserThread < ActiveRecord::Base
  
  belongs_to :user
  
  def self.find_profile_shouts(profile)
    UserThread.where(:target_id => profile.user_id, :thread_type => :profile)
  end
  
  def self.find_shouters(shouts)
    shouter_ids = []
    
    for shout in shouts
      shouter_ids << shout.user_id 
    end
    
    shouters = {}
    
    users = User.where(:id => shouter_ids).includes(:profile)
    
    for u in users
      shouters[u.id] = {:user => u, :username => u.username, :photo => u.profile.photo, :first_name => u.profile.first_name, :last_name => u.profile.last_name}
    end
    
    shouters
  end
  
end
