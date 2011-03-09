class UserMailer < ActionMailer::Base
  
  #include SendGrid
  
  default :from => "no-reply@krb.heroku.com"
  
  def send_password_reset_instructions(user)
     # subject "Password Reset Instructions"
     # 
     #      from "Killer Resume Builder"
     # 
     #      recipients user.email
     # 
     #      sent_on Time.now
     # 
     #      body :edit_password_reset_url => edit_password_reset_url(user.perishable_token)
     mail(:to => "trivektor@gmail.com", :subject => "test")
  end
  
end
