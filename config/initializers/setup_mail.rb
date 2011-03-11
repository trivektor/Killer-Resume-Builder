ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :address => "smtp.gmail.com",
  :port => 587,
  :domain => "gmail.com",
  :username => "trivektor@gmail.com",
  :password => "peacefulmind",
  :authentication => "plain",
  :enable_starttls_auto => true
}