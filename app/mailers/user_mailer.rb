class UserMailer < ActionMailer::Base
  
  def password_reset_instructions
    recipients  "Tri Vuong <tri@trivuong.com>"
    from        "Killer Resume Builder"
    subject     "Test"
    sent_on     Time.now
    body        {}
  end
  
end
