# Load the Rails application.
require_relative 'application'
# Initialize the Rails application.
Rails.application.initialize!

gmail_user_name = ENV['GMAIL_USER_NAME']
gmail_app_password = ENV['GMAIL_APP_PASSWORD']

ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: gmail_user_name,
  password: gmail_app_password,
  authentication: :login,
  enable_starttls_auto: true
}
