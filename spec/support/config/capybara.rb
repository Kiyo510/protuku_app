# frozen_string_literal: true

require 'capybara/rspec'

RSpec.configure do |config|
  config.before(:each, type: :system) do
    driven_by :rack_test
  end

  config.before(:each, type: :system, js: true) do
    driven_by :selenium, using: :headless_chrome, screen_size: [1920, 1080],
                         options: { args: %w[headless disable-gpu no-sandbox disable-dev-shm-usage] }
  end
end
