class User < ActiveRecord::Base
  
  include Gravtastic
  gravtastic :size => 120
  
  # associations
  has_many :authorizations, :dependent => :destroy
  has_one :profile, :dependent => :destroy
  has_many :resumes, :dependent => :destroy, :order => 'created_at DESC'
  has_many :thoughts, :dependent => :destroy, :order => 'created_at DESC'
  has_many :user_threads, :dependent => :destroy, :order => 'created_at ASC'
  
  accepts_nested_attributes_for :profile
  
  # virtual attributes
  attr_accessor :first_name, :last_name
  
  # validations
  validates_presence_of :first_name
  validates_presence_of :last_name
  validates_length_of :username, :minimum => 4, :message => " is too short"
  validates :email, :email => {:message => " is not valid"}
  validates_uniqueness_of :email, :case_sensitive => false
  validates_uniqueness_of :username, :case_sensitive => false
  validates_length_of :password, :minimum => 4, :message => " is too short"
  
  # authlogic
  acts_as_authentic do |config|
    config.crypto_provider = Authlogic::CryptoProviders::MD5
    config.maintain_sessions = false
    config.validate_email_field = false
    config.validate_login_field = false
    config.validate_password_field = false
    config.login_field = :email
    config.validate_login_field = false
  end
  
  def self.create_from_hash!(hash)
    user = User.new(:username => Time.now.to_i, :email => '', :auth_provider => hash['provider'])
    user.save(:validate => false)
    if hash['provider'].downcase == 'twitter'
      user.profile = Profile.create(:first_name => Twitter.user(hash['user_info']['nickname']).name)
    else
      user.profile = Profile.create(:first_name => hash['user_info']['first_name'], :last_name => hash['user_info']['last_name'])
    end
    user
  end
  
  def deliver_password_reset_instructions!
    reset_perishable_token!
    UserMailer.deliver_password_reset_instructions(self)
  end
  
  def activate!
    self.active = true
    save(false)
  end
  
  def deliver_activation_instructions!
    reset_perishable_token!
    UserMailer.deliver_activation_instructions(self)
  end
  
end
