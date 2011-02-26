class User < ActiveRecord::Base
  
  has_one :profile, :dependent => :destroy
  has_many :resumes, :dependent => :destroy
  has_many :thoughts, :dependent => :destroy
  has_many :user_threads, :dependent => :destroy
  
  accepts_nested_attributes_for :profile
  
  attr_accessor :first_name, :last_name
  
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_length_of :username, :minimum => 4, :message => " is too short"
  validates :email, :email => {:message => " is not valid"}
  validates_uniqueness_of :email
  validates_uniqueness_of :username
  validates_length_of :password, :minimum => 4, :message => " is too short"
  
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
    config.login_field = :email
    config.validate_login_field = false
  end
  
end
