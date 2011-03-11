class UserMailer < ActionMailer::Base
  
  def password_reset_instructions(user)
    # recipients  "Tri Vuong <tri@trivuong.com>"
    #     from        "Killer Resume Builder"
    #     subject     "Test"
    #     sent_on     Time.now
    #     body        { :user => user, :url => "http//www.google.com", :host => "krb.heroku.com" }
    mail :to => "tri.vuong@utoronto.ca", :subject => "Test"
  end
  
end
