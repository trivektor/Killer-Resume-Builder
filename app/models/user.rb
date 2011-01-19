class User < ActiveRecord::Base
  
  validates_length_of :username, :minimum => 4, :message => " is too short"
  validates :email, :email => {:message => " is not valid"}
  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4, :message => " is too short"
  
  has_one :profile
  
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
    config.login_field = :email
    config.validate_login_field = false
  end
  
  attr_accessible :username, :password, :email
  
  
  
end
