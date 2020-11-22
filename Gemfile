# frozen_string_literal: true

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails'
gem 'rails', '~> 6.0', '>= 6.0.3.4'
# Use mysql as the database for Active Record
gem 'mysql2', '>= 0.4.4'
# Use Puma as the app server
gem 'puma', '~> 4.1'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker', '~> 4.0'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'
# Use haml as a template engine
gem 'haml-rails'
# Use kaminari for a pagenation
gem 'kaminari', '~> 1.2', '>= 1.2.1'
# Use fontawesome
gem 'font-awesome-rails', '~> 4.7', '>= 4.7.0.5'
# Use jquery-rails
# Use Active Storage variant
# gem 'image_processing', '~> 1.2'
gem 'dotenv-rails'
gem 'marked-rails'
gem 'omniauth'
gem 'omniauth-twitter'
gem 'redcarpet'
gem 'rouge'
# Reduces boot times through caching; required in config/boot.rb
gem 'active_hash'
gem 'active_storage_validations'
gem 'aws-sdk-s3', require: false
gem 'bootsnap', '>= 1.4.2', require: false
gem 'high_voltage', '~> 3.1', '>= 3.1.2'
gem 'mini_magick'
gem 'rails-i18n'


group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'bullet'
  gem 'listen', '~> 3.2'
  gem 'web-console', '>= 3.3.0'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'ast', '~> 2.4', '>= 2.4.1'
  gem 'faker', '~> 2.12'
  gem 'letter_opener'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15'
  gem 'selenium-webdriver'
  gem 'spring-commands-rspec'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'launchy'
  gem 'rspec_junit_formatter'
  gem 'shoulda-matchers', '~> 4.3'
  gem 'webdrivers'
end

group :development, :test do
  gem 'factory_bot_rails', '~> 6.0'
  gem 'pry-byebug'
  gem 'pry-rails'
  gem 'rspec-rails', '4.0.0.beta3'
  gem 'rubocop'
  gem 'rubocop-packaging'
  gem 'rubocop-performance'
  gem 'rubocop-rails'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: %i[mingw mswin x64_mingw jruby]
