ActionMailer::Base.delivery_method = :smtp
ActionMailer::Base.smtp_settings = {
  address: 'smtp.gmail.com',
  domain: 'gmail.com',
  port: 587,
  user_name: 'miraishida00510@gmail.com',
  password: 'ogqlbhuplejgshuz',
  authentication: :login,
  enable_starttls_auto: true
}
