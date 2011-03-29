class UserMailer < ActionMailer::Base
  
  def password_reset_instructions(user)
    subject "Password Reset Instructions"
    from  "Killer Resume Builder <tri@trivuong.com>"
    recipients user.email
    sent_on     Time.now
    body        :password_reset_url => edit_password_reset_url(user.perishable_token)
  end
  
  def activation_instructions(user)
    subject "Activation Instructions"
    from "Killer Resume Builder <tri@trivuong.com>"
    recipients user.email
    sent_on Time.now
    body :account_activation_url => activation_url(user.perishable_token)
  end
  
end
