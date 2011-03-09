class Notifier < ActionMailer::Base
  
  include SendGrid
  
  default_url_options[:host] = "krb.heroku.com"
  
  def password_reset_instructions(user)
    
    
    
  end
  
  def send_password_reset_email
    
  end
  
end