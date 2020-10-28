# Load the Rails application.
require_relative 'application'
# Initialize the Rails application.
Rails.application.initialize!
config.action_mailer.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: ENV['GMAIL_USER_NAME'],
  password: ENV['GMAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
