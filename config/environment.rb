# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Krb::Application.initialize!

ActionMailer::Base.smtp_settings = {
  :address => "stmp.sendgrid.net",
  :port => "25",
  :domain => "krb.heroku.com",
  :authentication => :plain,
  :username => "trivektor@gmail.com",
  :password => "mnbvcxz"
}