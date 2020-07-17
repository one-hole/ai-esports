source 'https://gems.ruby-china.com/'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '2.7.1'

gem 'jbuilder', '~> 2.5'
gem 'mysql2', '~> 0.5'
gem 'puma', '~> 4.3'
gem 'rails', '~> 6.0.2', '>= 6.0.3 '

gem 'connection_pool', '~> 2.2', '>= 2.2.2'
gem 'redis', '~> 4.0'
gem 'redis-objects', '~> 1.4', '>= 1.4.3'

gem 'bcrypt', '~> 3.1', '>= 3.1.12'
gem 'rest-client', '~> 2.1'
gem 'rsa-tools'
gem 'typhoeus', '~> 1.3'

gem 'active_type'

gem 'active_model_serializers', '~> 0.10.7'
gem 'kaminari', '~> 1.1', '>= 1.1.1'
# gem 'active_model_serializers', github: 'rails-api/active_model_serializers'
gem 'ohm'
gem 'sidekiq', '5.2.5'
gem 'sidekiq-unique-jobs', '~> 6.0', '>= 6.0.21'

gem 'rack-cors', require: 'rack/cors'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.1.0', require: false
gem 'dota2-constant', github: 'w-zengtao/dota2-constant-rb' 

group :development, :test do
  gem 'awesome_print'
  gem 'amazing_print'
  gem 'factory_bot_rails', '~> 4.10'
  gem 'mina'
  gem 'mina-puma', require: false
  gem 'pry'
  gem 'rspec-rails', '~> 3.7'
end

group :test do
  gem 'database_cleaner'
end

group :development do
  gem 'listen', '>= 3.0.5', '< 3.2'
  gem 'pry-rails'
  gem 'spring'
  gem 'spring-watcher-listen', '~> 2.0.0'
  gem 'web-console', '>= 3.3.0'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 2.15', '< 4.0'
  gem 'selenium-webdriver'
  # Easy installation and use of chromedriver to run system tests with Chrome
  gem 'chromedriver-helper'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]
