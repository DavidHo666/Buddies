# source "https://rubygems.org"
# git_source(:github) { |repo| "https://github.com/#{repo}.git" }
#
# ruby "3.1.0"
#
# # Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
# gem "rails", "~> 7.0.3", ">= 7.0.3.1"
#
# # The original asset pipeline for Rails [https://github.com/rails/sprockets-rails]
# gem "sprockets-rails"
#
# # Use sqlite3 as the database for Active Record
# gem "sqlite3", "~> 1.4"
#
# # Use sqlite3 as the database for Active Record
# gem "pg"
#
# # Use the Puma web server [https://github.com/puma/puma]
# gem "puma", "~> 5.0"
#
# # Use JavaScript with ESM import maps [https://github.com/rails/importmap-rails]
# gem "importmap-rails"
#
# # Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
# gem "turbo-rails"
#
# # Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
# gem "stimulus-rails"
#
# # Build JSON APIs with ease [https://github.com/rails/jbuilder]
# gem "jbuilder"
#
# # Use Redis adapter to run Action Cable in production
# # gem "redis", "~> 4.0"
#
# # Use Kredis to get higher-level data types in Redis [https://github.com/rails/kredis]
# # gem "kredis"
#
# # Use Active Model has_secure_password [https://guides.rubyonrails.org/active_model_basics.html#securepassword]
# # gem "bcrypt", "~> 3.1.7"
#
# # Windows does not include zoneinfo files, so bundle the tzinfo-data gem
# gem "tzinfo-data", platforms: %i[ mingw mswin x64_mingw jruby ]
#
# # Reduces boot times through caching; required in config/boot.rb
# gem "bootsnap", require: false
#
# # Use Sass to process CSS
# # gem "sassc-rails"
#
# # Use Active Storage variants [https://guides.rubyonrails.org/active_storage_overview.html#transforming-images]
# # gem "image_processing", "~> 1.2"
#
# gem 'allow_numeric'
gem 'devise', '~> 4.8', '>= 4.8.1'
#
# group :development, :test do
#   # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
#   gem "debug", platforms: %i[ mri mingw x64_mingw ]
# end
#
# group :development do
#   # Use console on exceptions pages [https://github.com/rails/web-console]
#   gem "web-console"
#
#   # Add speed badges [https://github.com/MiniProfiler/rack-mini-profiler]
#   # gem "rack-mini-profiler"
#
#   # Speed up commands on slow machines / big apps [https://github.com/rails/spring]
#   # gem "spring"
# end
#
# group :test do
#   # Use system testing [https://guides.rubyonrails.org/testing.html#system-testing]
#   gem "capybara"
#   gem "selenium-webdriver"
#   gem "webdrivers"
#   gem 'simplecov', :require => false
#   gem 'cucumber-rails', require: false
#   # database_cleaner is not mandatory, but highly recommended
#   gem 'database_cleaner'
# end
#
# source "https://rubygems.org"
# gem "rspec"
# gem 'rails-controller-testing'
#
# group :development, :test do
#   gem 'rspec-rails'
# end

source 'https://rubygems.org'
git_source(:github) { |repo| "https://github.com/#{repo}.git" }

ruby '3.1.0'

# Bundle edge Rails instead: gem 'rails', github: 'rails/rails', branch: 'main'
gem "rails", "~> 7.0.3", ">= 7.0.3.1"
# Use sqlite3 as the database for Active Record
gem 'sqlite3', '~> 1.4'
# Use Puma as the app server
gem 'puma', '~> 5.0'
# Use SCSS for stylesheets
gem 'sass-rails', '>= 6'
# Transpile app-like JavaScript. Read more: https://github.com/rails/webpacker
gem 'webpacker'
# Turbolinks makes navigating your web application faster. Read more: https://github.com/turbolinks/turbolinks
gem 'turbolinks', '~> 5'
# Build JSON APIs with ease. Read more: https://github.com/rails/jbuilder
gem 'jbuilder', '~> 2.7'
# Use Redis adapter to run Action Cable in production
# gem 'redis', '~> 4.0'
# Use Active Model has_secure_password
gem 'bcrypt', '~> 3.1.7'

# Use Active Storage variant
# gem 'image_processing', '~> 1.2'

# Reduces boot times through caching; required in config/boot.rb
gem 'bootsnap', '>= 1.4.4', require: false

group :development, :test do
  # Call 'byebug' anywhere in the code to stop execution and get a debugger console
  gem 'byebug', platforms: [:mri, :mingw, :x64_mingw]
end

group :development do
  # Access an interactive console on exception pages or by calling 'console' anywhere in the code.
  gem 'web-console', '>= 4.1.0'
  # Display performance information such as SQL time and flame graphs for each request in your browser.
  # Can be configured to work on production as well see: https://github.com/MiniProfiler/rack-mini-profiler/blob/master/README.md
  # gem 'rack-mini-profiler', '~> 2.0'
  gem 'listen', '~> 3.3'
  # Spring speeds up development by keeping your application running in the background. Read more: https://github.com/rails/spring
  gem 'spring'
end

group :test do
  # Adds support for Capybara system testing and selenium driver
  gem 'capybara', '>= 3.26'
  gem 'selenium-webdriver'
  # Easy installation and use of web drivers to run system tests with browsers
  gem 'webdrivers'
end

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem 'tzinfo-data', platforms: [:mingw, :mswin, :x64_mingw, :jruby]

# Oauth
gem 'omniauth'
gem 'omniauth-google-oauth2'
gem 'dotenv-rails'
gem 'omniauth-rails_csrf_protection'

# Paginator
gem 'kaminari'

# HTTP Client
gem 'excon'

# Geocoding
gem 'geocoder'
