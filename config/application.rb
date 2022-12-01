require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Buddies
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 7.0

    # Configuration for the application, engines, and railties goes here.
    #
    # These settings can be overridden in specific environments using the files
    # in config/environments, which are processed later.
    #
    # config.time_zone = "Central Time (US & Canada)"
    # config.eager_load_paths << Rails.root.join("extras")
    # config.time_zone = 'Eastern Time (US & Canada)'
    # config.assets.initialize_on_precompile = false
    config.action_mailer.default_url_options = { :host => 'IP ADDRESS HERE:3000' }
  
    config.action_mailer.raise_delivery_errors = true
    config.action_mailer.delivery_method = :smtp
    # config.action_mailer.default_url_options = { 
    #   :host => '<your_url_here>', 
    #   :protocol => 'http'
    # }
    config.action_mailer.smtp_settings = {
      :address              => 'smtp.gmail.com',
      :port                 => 587,
      :domain               => 'gmail.com',
      :user_name            => 'elysiaswroth@gmail.com',
      :password             => 'yffkrsbtlkeknnzz',
      :authentication       => 'login',
      :enable_starttls_auto => true
    }
  end
end