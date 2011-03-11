ActionMailer::Base.delivery_method = :smtp

ActionMailer::Base.smtp_settings = {
  :tls => true,
  :address => "smtp.gmail.com",
  :port => 465,
  :domain => "gmail.com",
  :username => "trivektor@gmail.com",
  :password => "peacefulmind",
  :authentication => "plain",
  :enable_starttls_auto => true
}