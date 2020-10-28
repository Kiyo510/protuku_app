require_relative 'boot'

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Webapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.0
    config.generators do |g|
      g.test_framework :rspec,
       fixtures: false, # テストDBにレコード作成するファイルの作成をスキップ（初めだけ、のちに削除）。
       controller_specs: false,
       view_specs: false, # ビューファイル用のスペックを作成しない。
       helper_specs: false, # ヘルパーファイル用のスペックを作成しない。
       routing_specs: false # routes.rb用のスペックファイル作成しない。
    end
    config.generators.system_tests = nil
    config.action_mailer.perform_deliveries = true
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    config.action_mailer.default_url_options = { :host => 'protuku.com', port: 80 }
    gmail_user_name = ENV['GMAIL_USER_NAME']
    gmail_app_password = ENV['GMAIL_APP_PASSWORD']
    config.action_mailer.smtp_settings = {
      address: 'smtp.gmail.com',
      domain: 'gmail.com',
      port: 587,
      user_name: gmail_user_name,
      password: gmail_app_password,
      authentication: :login,
      enable_starttls_auto: true
    }
    config.i18n.default_locale = :ja
    config.i18n.load_path += Dir[Rails.root.join('config', 'locales', '**', '*.yml').to_s]
  end
end
