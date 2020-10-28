# Load the Rails application.
require_relative 'application'
# Initialize the Rails application.
# Rails.application.configure do
#   config.action_mailer.raise_delivery_errors = true
#   config.action_mailer.delivery_method = :smtp
#   config.action_mailer.default_url_options = { :host => 'protuku.com' }
#   config.action_mailer.smtp_settings = {
#     address: 'smtp.gmail.com',
#     domain: 'smtp.gmail.com',
#     port: 587,
#     user_name: ENV['GMAIL_USER_NAME'],
#     password: ENV['GMAIL_APP_PASSWORD'],
#     authentication: :plain,
#     enable_starttls_auto: true
#   }
# end
Rails.application.initialize!
