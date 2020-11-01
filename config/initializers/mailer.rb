ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
<<<<<<< Updated upstream
  user_name: 'miraishida00510@gmail.com',
=======
  user_name: ENV['GMAIL_USER_NAME'],
>>>>>>> Stashed changes
  password: ENV['GMAIL_APP_PASSWORD'],
  authentication: :login,
  enable_starttls_auto: true
}
