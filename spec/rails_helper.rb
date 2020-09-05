# This file is copied to spec/ when you run 'rails generate rspec:install'
require 'database_cleaner'
require 'spec_helper'
ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
abort('The Rails environment is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'factory_bot'
require 'faker'
require 'capybara/rspec'

Dir[Rails.root.join('spec/support/**/*.rb')].sort.each { |file| require file }
begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  puts e.to_s.strip
  exit 1
end
RSpec.configure do |config|
  config.fixture_path = "#{::Rails.root}/spec/fixtures"
  config.use_transactional_fixtures = false
  config.infer_spec_type_from_file_location!
  config.before(:each, type: :system) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080],
                        options: { args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage] }
  end
  DatabaseCleaner.strategy = :truncation
  config.before(:suite) do
    DatabaseCleaner.clean
  end
  config.before(:each) do
    DatabaseCleaner.clean
  end
  config.after(:suite) do
    DatabaseCleaner.clean
  end
  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  # config.filter_gems_from_backtrace("gem name")
  config.include FactoryBot::Syntax::Methods
  config.include LoginSupport # 作成したヘルパーを追加
end

Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
