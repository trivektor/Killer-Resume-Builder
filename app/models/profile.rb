class Profile < ActiveRecord::Base
  
  belongs_to :user, :dependent => :destroy, :foreign_key => "user_id"
  
end
